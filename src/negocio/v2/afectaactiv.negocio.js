const Validator = require('../../../config/complementos/validator')
const objvalit = new Validator()
const Bdafectaactiv = require('../../model/v2/afectaactiv.bd')
const objafectaactiv = new Bdafectaactiv()
const Bdactivprocesanali = require('../../model/v2/activprocesanali.bd')
const objactivprocesanali = new Bdactivprocesanali()
const BdtipoActiv = require('../../model/v2/tipoActiv.bd')
const objtipoActiv = new BdtipoActiv()
const BdafectaTip = require('../../model/v2/afectaTip.bd')
const objafectaTip = new BdafectaTip()
const BdvaloriAmenasDim = require('./valoriAmenasDim.negocio')
const objvaloriAmenasDim = new BdvaloriAmenasDim()

const Valideinsert = (req) => {
  const valida =
    objvalit.validator_vacio(req.body.esenario)

  const dataarray = [
    {
      datacom: 'esenario',
      valide: objvalit.validator_vacio(req.body.esenario)
    }
  ]

  const auxvalidetdata = dataarray.filter((item) => {
    return item.valide
  })
  console.log(auxvalidetdata)
  return { valida, auxvalidetdata }
}

const valideInserAreaRepit = async (req, res) => {
  try {
    const idActivProsVerAnali = req.body.id_activProsVerAnali
    const idAmenaza = req.body.id_amenaza
    const resultCom = await objafectaactiv.list_afectaactiv(req, res, idActivProsVerAnali)
    const filterData = resultCom.filter((item) => {
      return parseInt(item.id_amenaza) === parseInt(idAmenaza)
    })
    return filterData.length > 0
  } catch (error) {
    return true
  }
}

module.exports = class ngclienAnalit {
  async generarAmenazas (req, res) {
    const idLibreryAmen = req.body.id_libreryAmen
    const idAactivProctAnali = req.body.id_activProsVerAnali
    // se substrae la informacion del activo a analisar
    const result = await objactivprocesanali.read_activprosveranali(req, res, idAactivProctAnali)
    const objActivAnalit = result[0]
    // analizar los tipos de activos
    const listKeyTotal = await objtipoActiv.list_tipoActiv(req, res, 0)
    const arbolDepen = this.strackAbrebArray(objActivAnalit.dependAbreb)
    const lisKey = arbolDepen.map((item) => {
      // detectar la key de la abrebiatura
      const keydata = listKeyTotal.filter((tipact) => {
        return (tipact.dependAbreb + '') === (item + '')
      })[0]
      return {
        key: keydata.id_tipoActivo,
        abreb: item
      }
    })
    // buscar las amenazas de cada activo
    const listAmenasTip = await objafectaTip.list_afectaTip(req, res, idLibreryAmen)
    const listAmensActiv = lisKey.map((item) => {
      // detectar la key de la abrebiatura
      const listAmn = listAmenasTip.filter((amenasEnlace) => {
        return parseInt(amenasEnlace.id_tipoActivo) === parseInt(item.key)
      })
      return listAmn
    })
    // console.log(listAmensActiv)
    // lista de amenasas de un activo
    // captura si con el tipo de activo primcipal tiene amenazas, sino se hereda del tipo padre
    listAmensActiv.reverse()
    const finalArray = listAmensActiv.reduce((prev, current) => {
      const curr = [...current]
      const arrayAux = [...prev, ...curr]
      return (parseInt(prev.length) === 0) ? arrayAux : prev
    }, [])
    return finalArray
  }

  strackAbrebArray (abreb = 'essential.info.per.regular.5') {
    const ListItemAbrebitem = abreb.split('.')
    const ListCombItemAbrebitem = []
    ListItemAbrebitem.forEach((item) => {
      if (ListCombItemAbrebitem.length === 0) {
        ListCombItemAbrebitem.push(item)
      } else {
        const abrebItem = ListCombItemAbrebitem[ListCombItemAbrebitem.length - 1] + '.' + item
        ListCombItemAbrebitem.push(abrebItem)
      }
    })
    return ListCombItemAbrebitem
  }

  async cargarAmenazas (req, res) {
    // validar si ya tienen amenazas designadas
    const result = await objafectaactiv.list_afectaactiv(req, res, req.body.id_activProsVerAnali)
    if (parseInt(result.length) !== 0) {
      res.send({
        status: 404,
        typo: 'error',
        messege: 'El activo ya presenta amenazas designadas, si se desea agregar otra amenaza, realiselo de forma manual.',
        data: []
      })
      // eslint-disable-next-line no-useless-return
      return
    }
    // const validado = Valideinsert(req)
    const arrayAmen = await this.generarAmenazas(req, res)
    if (parseInt(arrayAmen.length) === 0) {
      res.send({
        status: 404,
        typo: 'error',
        messege: 'El activo no presenta amenazas, se solicita un enlace de manea manual',
        data: []
      })
      // eslint-disable-next-line no-useless-return
      return
    }

    for (let index = 0; index < arrayAmen.length; index++) {
      const element = arrayAmen[index]
      await objafectaactiv.inser_afectaactiv(req, res, true, { idActivProsVerAnali: req.body.id_activProsVerAnali, idAmenaza: element.id_amenazas })
    }

    res.send({
      status: 200,
      typo: 'succes',
      messege: 'Las amenazas se designaron de manera correcta.'
    })
  }

  async inser_afectaactiv (req, res) {
    // validar si ya tienen amenazas designadas
    const resultValid = await valideInserAreaRepit(req, res)

    if (resultValid) {
      res.send({
        status: 404,
        typo: 'error',
        messege: 'Esta amenaza ya fue designada al activo de analisis.',
        data: []
      })
      // eslint-disable-next-line no-useless-return
      return
    }

    const resultIn = await objafectaactiv.inser_afectaactiv(req, res)

    res.send({
      status: 200,
      typo: 'succes',
      messege: resultIn
    })
  }

  async actualizar_afectaactiv (req, res) {
    // validar datos insertados
    const validado = Valideinsert(req)

    if (validado.valida) {
      res.send({
        status: 404,
        typo: 'error',
        messege: 'Casillas mal ingresadas',
        data: validado.auxvalidetdata
      })
      // eslint-disable-next-line no-useless-return
      return
    }

    // si todo esta correcto, inserta los datos
    const result = await objafectaactiv.actualizar_afectaactiv(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }

  async list_afectaactiv (req, res) {
    const result = await objafectaactiv.list_afectaactiv(req, res)
    // varificar que los datos sean correctos
    const CompruResul = result.filter((item) => {
      return (item.id_valorAfectAmen != null) && (item.id_Frecuencia != null) && (item.id_DegradCualit != null)
    })
    // cargar la informacion de cada valorizacion de la dimension
    for (let index = 0; index < CompruResul.length; index++) {
      const element = CompruResul[index]
      req.body.id_valorAfectAmen = element.id_valorAfectAmen
      await objvaloriAmenasDim.cargar_valorizacionRiesgo(req, res)
    }
    const listResult = await objafectaactiv.list_afectaactiv(req, res)
    res.json(listResult)
  }

  async delete_afectaactiv (req, res) {
    const result = await objafectaactiv.delete_afectaactiv(req, res)
    res.json(result)
  }
}
