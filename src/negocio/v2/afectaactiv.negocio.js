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
const Bdactivproces = require('../../model/v2/activproces.bd')
const objactivproces = new Bdactivproces()
const Bdinsidencias = require('../../model/v2/insidencias.bd')
const objinsidencias = new Bdinsidencias()
const Bdamenazas = require('../../model/v2/amenazas.bd')
const objamenazas = new Bdamenazas()
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

  async generarAmenazasInsidencias (req, res) {
    // const idLibreryAmen = req.body.id_libreryAmen
    const idAactivProctAnali = req.body.id_activProsVerAnali
    // se substrae la informacion del activo a analisar
    const result = await objactivprocesanali.read_activprosveranali(req, res, idAactivProctAnali)
    if (parseInt(result.length) === 0) return []
    const objActivAnalit = result[0]
    // console.log(objActivAnalit)
    // analizar el proceso al que pertenece el activo
    const listKeyTotal = await objactivproces.list_activproces(req, res, 0)
    const InformActivPros = listKeyTotal.filter((item) => {
      return parseInt(item.id_activproc) === parseInt(objActivAnalit.id_activProc)
    })
    if (parseInt(InformActivPros.length) === 0) return []
    const objActivPros = InformActivPros[0]
    // console.log(objActivPros)
    // analizar las insidencias que puede tener un proceso
    const listInsidentProces = await objinsidencias.list_insidencias(req, res, objActivPros.id_proceso)
    const objListInsidentProces = listInsidentProces.filter((item) => {
      return parseInt(item.id_activProc) === parseInt(objActivAnalit.id_activProc)
    }).map((item) => { return item.id_amenaza })
    if (parseInt(objListInsidentProces.length) === 0) return []
    // console.log(objListInsidentProces)
    // capturar las amenazas
    const listAmenaz = await objamenazas.list_amenas(req, res, 0)
    const listAmenazInside = listAmenaz.filter((item) => {
      return objListInsidentProces.indexOf(item.id_amenaza) !== -1
    })
    return listAmenazInside
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
    // -------------------------------------------------------------------------------------------- generar las amenazas a partir de las insidencias
    if (parseInt(req.body.id_libreryAmen) === 1) {
      const listamenaszInsidens = await this.generarAmenazasInsidencias(req, res)
      if (parseInt(listamenaszInsidens.length) === 0) {
        res.send({
          status: 404,
          typo: 'error',
          messege: 'El activo no presenta amenazas, se solicita un enlace de manea manual',
          data: []
        })
        // eslint-disable-next-line no-useless-return
        return
      }

      for (let index = 0; index < listamenaszInsidens.length; index++) {
        const element = listamenaszInsidens[index]
        console.log(element)
        await objafectaactiv.inser_afectaactiv(req, res, true, { idActivProsVerAnali: req.body.id_activProsVerAnali, idAmenaza: element.id_amenaza })
      }

      res.send({
        status: 200,
        typo: 'succes',
        messege: 'Las amenazas segun las insidencias se designaron de manera correcta.'
      })
      return
    }
    // -------------------------------------------------------------------------------------------- generar las amenazas a partir de una libreria
    let arrayAmen = await this.generarAmenazas(req, res)
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
    // comprueba si hay insidencias agregadas, para ser anadida a la lista de amenazas
    const listamenaInside = await this.generarAmenazasInsidencias(req, res)
    if (parseInt(listamenaInside.length) !== 0) {
      const listkeyopccion = arrayAmen.map((item) => { return item.id_amenazas })
      // comprueba si la lista de amenazas alineada de insidencias esta dentro de la lista de amenazas
      const listFilter = listamenaInside.filter((item) => {
        return listkeyopccion.indexOf(item.id_amenaza) === -1
      })
      const listMapFilter = listFilter.map((item) => {
        return {
          id_amenazas: item.id_amenaza,
          id_libreryAmen: 1,
          nombreLibreyAmen: 'Insidencia',
          id_tipoActivo: item.id_tipoActiv,
          dependAbreb: item.abreb
        }
      })
      arrayAmen = [...arrayAmen.concat(listMapFilter)]
    }
    // -------------------------------------------------------------------------------
    for (let index = 0; index < arrayAmen.length; index++) {
      const element = arrayAmen[index]
      await objafectaactiv.inser_afectaactiv(req, res, true, { idActivProsVerAnali: req.body.id_activProsVerAnali, idAmenaza: element.id_amenazas })
    }

    res.send({
      status: 200,
      typo: 'succes',
      messege: `Las amenazas se designaron de manera correcta, pero esta activo presenta ${listamenaInside.length} insidencias.`
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

  async list_afectaactiv (req, res, idActivProsVerAnali = 0) {
    const result = await objafectaactiv.list_afectaactiv(req, res, (parseInt(idActivProsVerAnali) === 0) ? req.params.id_activProsVerAnali : idActivProsVerAnali)
    // varificar que los datos sean correctos
    const CompruResul = result.filter((item) => {
      return (item.id_valorAfectAmen != null) && (item.id_Frecuencia != null) && (item.id_DegradCualit != null)
    })
    if (CompruResul.length !== 0) {
      // cargar la informacion de cada valorizacion de la dimension
      for (let index = 0; index < CompruResul.length; index++) {
        const element = CompruResul[index]
        req.body.id_valorAfectAmen = element.id_valorAfectAmen
        await objvaloriAmenasDim.cargar_valorizacionRiesgo(req, res)
      }
      // recargar la informacion
      const listResult = await objafectaactiv.list_afectaactiv(req, res)
      const listResultAux = listResult.map((item) => {
        const objJson = { ...item }
        if ((item.id_valorAfectAmen == null) && (item.id_Frecuencia == null) && (item.id_DegradCualit == null)) return item
        const valImpacCualit = Math.round(parseInt(item.valoriActivCualiti) * (parseInt(item.valDegradCualit) / 100))
        // console.log(Math.round(parseInt(item.valoriActivCualiti) * (parseInt(item.valDegradCualit) / 100)))
        objJson.valImpacCualit = valImpacCualit
        objJson.valRiesgoCualit = (parseInt(valImpacCualit) * parseInt(item.valorFrecuenCuali))
        // console.log(objJson)
        return objJson
      })
      return listResultAux
    }
    return result
  }

  async list_afectaactiv_insidencia (req, res, idActivProsVerAnali = 0, idAmenazas1 = 0) {
    // const idLibreryAmen = req.body.id_libreryAmen
    const idAactivProctAnali = (parseInt(idActivProsVerAnali) === 0) ? req.params.id_activProsVerAnali : idActivProsVerAnali
    const idAmenazas = (parseInt(idAmenazas1) === 0) ? req.params.id_amenazas : idAmenazas1
    // se substrae la informacion del activo a analisar
    const result = await objactivprocesanali.read_activprosveranali(req, res, idAactivProctAnali)
    if (parseInt(result.length) === 0) return []
    const objActivAnalit = result[0]
    // console.log(objActivAnalit)
    // analizar el proceso al que pertenece el activo
    const listKeyTotal = await objactivproces.list_activproces(req, res, 0)
    const InformActivPros = listKeyTotal.filter((item) => {
      return parseInt(item.id_activproc) === parseInt(objActivAnalit.id_activProc)
    })
    if (parseInt(InformActivPros.length) === 0) return []
    const objActivPros = InformActivPros[0]
    // analizar las insidencias que puede tener un proceso
    const listInsidentProces = await objinsidencias.list_insidencias(req, res, objActivPros.id_proceso)
    const listFilterInsidentProces = listInsidentProces.filter((item) => {
      return parseInt(item.id_amenaza) === parseInt(idAmenazas)
    })
    return listFilterInsidentProces
  }

  async delete_afectaactiv (req, res) {
    const result = await objafectaactiv.delete_afectaactiv(req, res)
    res.json(result)
  }
}
