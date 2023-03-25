const Bdafectaactiv = require('../../model/v2/afectaactiv.bd')
const objafectaactiv = new Bdafectaactiv()
const BdvaloriActiv = require('../../model/v2/valoriActiv.bd')
const objvaloriActiv = new BdvaloriActiv()
const BdvaloriActivDim = require('../../model/v2/valoriActivDim.bd')
const objvaloriActivDim = new BdvaloriActivDim()
const BdvaloriAmenas = require('../../model/v2/valoriAmenas.bd')
const objvaloriAmenas = new BdvaloriAmenas()
const BdvaloriAmenasDim = require('../../model/v2/valoriAmenasDim.bd')
const objvaloriAmenasDim = new BdvaloriAmenasDim()
const BdafectaDimem = require('../../model/v2/afectaDimem.bd')
const objafectaDimem = new BdafectaDimem()
const BdescalFrecuen = require('../../model/v2/escalFrecuen.bd')
const objescalFrecuen = new BdescalFrecuen()
const BdescalDegrad = require('../../model/v2/escalDegrad.bd')
const objescalDegrad = new BdescalDegrad()
const BdescalImpac = require('../../model/v2/escalImpac.bd')
const objescalImpac = new BdescalImpac()
const BdescalRiesgo = require('../../model/v2/escalRiesgo.bd')
const objescalRiesgo = new BdescalRiesgo()

async function validarValoriActivo (req, res, idValorAfectAmen = 0) {
  // extraer la informacion de la afectacion de la amenaza
  const listAmenasActiv = await objvaloriAmenas.read_valorafectamen(req, res, idValorAfectAmen)
  if (listAmenasActiv.length === 0) { return false }
  const idAmenaza = listAmenasActiv[0]
  // extraer informacion de la amenaza
  const listAmenas = await objafectaactiv.read_afectaactiv(req, res, idAmenaza.id_afectaActiv)
  if (listAmenas.length === 0) { return false }
  const objAmen = listAmenas[0]
  // cargar la valorizacion de los activos
  const listValoriActiv = await objvaloriActiv.list_valoractiv(req, res, objAmen.id_activProsVerAnali)
  if (listValoriActiv.length === 0) { return false }
  const objActivValori = listValoriActiv[0]
  // validar si realizan una valorizacion
  if ((parseInt(objActivValori.valorActivCuanti) === 0) && (parseInt(objActivValori.promValorCuanti) === 0)) return false
  return true
}

module.exports = class NegValoriAmenDim {
  // si da una respuesta [] es porque no afercta a ninguna dimension
  async extracDimensionAmenaza (req, res) {
    // extraer la informacion de la afectacion de la amenaza
    const listAmenasActiv = await objvaloriAmenas.read_valorafectamen(req, res, req.body.id_valorAfectAmen)
    if (listAmenasActiv.length === 0) { return [] }
    const idAmenaza = listAmenasActiv[0]
    // extraer informacion de la amenaza
    const listAmenas = await objafectaactiv.read_afectaactiv(req, res, idAmenaza.id_afectaActiv)
    if (listAmenas.length === 0) { return [] }
    const objAmen = listAmenas[0]
    // extraer las dimensiones que afecta una amenaza
    const listAmenDimens = await objafectaDimem.list_afectaDimem(req, res)
    const listDimens = listAmenDimens.filter((item) => { return parseInt(item.id_amenaza) === parseInt(objAmen.id_amenaza) })
    return listDimens
  }

  async compruebeExistenValori (req, res, idValorAfectAmen = 0) {
    const resul = await validarValoriActivo(req, res, (parseInt(idValorAfectAmen) === 0) ? req.body.id_valorAfectAmen : idValorAfectAmen)
    // eslint-disable-next-line no-useless-return
    return {
      status: (resul) ? 200 : 404,
      typo: (resul) ? 'succes' : 'error',
      messege: (resul) ? 'La valorizacion de la amenaza puede ser ingresado.' : 'La valorizacion no puede ser insertada',
      data: resul
    }
  }

  async ValorizarAmenazasDegrad (req, res) {
    // se comprueba si se an enviado las dimenciones valorizadas
    if (req.body.dataValor.length === 0) {
      res.send({
        status: 404,
        typo: 'error',
        messege: 'No presenta una valorizacion de dimensiones, Ingresar dimensiones porfavor.',
        data: []
      })
      // eslint-disable-next-line no-useless-return
      return
    }
    // se comprueba si ya se realizo una valorizacion al activo
    const resul = await this.compruebeExistenValori(req, res, req.body.id_valorAfectAmen)
    if (resul.data) {
      res.send({
        status: 404,
        typo: 'error',
        messege: 'Error, no se a valizado al activo, lo cual puede suceder comflicto.',
        data: []
      })
      // eslint-disable-next-line no-useless-return
      return
    }
    // se comprueba si las dimensiones que obligatoriamente se tienen que valorizar estan
    const newlistDimekey = req.body.dataValor.map((item) => { return item.id_dimension })
    const listDimenAfect = await this.extracDimensionAmenaza(req, res)
    const listKeyDimenAfec = listDimenAfect.map((item) => { return item.id_dimension })
    const compreAfecDimen = newlistDimekey.map((item) => {
      return parseInt(listKeyDimenAfec.indexOf(item.id_dimension)) !== -1
    })
    if (parseInt(compreAfecDimen.length) === 0) {
      res.send({
        status: 404,
        typo: 'error',
        messege: 'La valorizacion no esta alineada a las dimensiones principales afectadas.',
        data: []
      })
      // eslint-disable-next-line no-useless-return
      return
    }
    // se comprueba si ya se a insertado una valorizacion antes
    const listValAfectAmenDimen = await objvaloriAmenasDim.list_valAfectAmenDimen(req, res, req.body.id_valorAfectAmen)
    if (parseInt(listValAfectAmenDimen.length) !== 0) {
      const listDimekey = listValAfectAmenDimen.map((item) => { return item.id_dimension })
      // se comprueba que aparte de la valorizacion de la dimension prinsipal, se an quitado dimensiones externas
      const compreElimDimen = listDimekey.filter((item) => {
        return parseInt(newlistDimekey.indexOf(item)) === -1
      })
      // elimina a todas las dimensiones que ya no se esten dando valorizacion
      for (let index = 0; index < compreElimDimen.length; index++) {
        const element = compreElimDimen[index]
        // se captura la informacion de la dimencion para su posterior eliminacion
        let dataDimen = listValAfectAmenDimen.filter((item) => {
          return parseInt(item.id_dimension) === parseInt(element)
        })
        if (dataDimen.length === 0) break
        console.log(dataDimen)
        dataDimen = dataDimen[0]
        // eliminacion de las dimensiones que ya no se desee una valorizacion
        await objvaloriAmenasDim.eliminar_valorafectamenDim(req, res, dataDimen.id_valAfectAmenDimen)
      }
    }
    // insersion normalizada
    // se realiza la insercion o actualizacion de cada una de las valorizaciones
    for (let index = 0; index < req.body.dataValor.length; index++) {
      let element = req.body.dataValor[index]
      // verifica si la insercion se dio por valorizacion o por insercion por escala
      if (!(element.valorDegrad >= 0 && element.valorDegrad <= 100)) {
        res.send({
          status: 404,
          typo: 'error',
          messege: `La dimencion con codigo ${element.id_dimension} presenta una valorizacion esta fuera del rango`
        })
        return
      }
      // se le captura su nivel de valorizacion
      const ObjnivelVal = await this.verifiEscalDegrad(req, res, element.valorDegrad)
      element = { id_escalDegrad: ObjnivelVal.id_escalDegrad, id_valorAfectAmen: req.body.id_valorAfectAmen, ...element }
      await objvaloriAmenasDim.insert_valorAfectAmenDim(req, res, true, { ...element })
    }

    await this.cargar_valorizacionRiesgo(req, res)

    res.send({
      status: 200,
      typo: 'succes',
      messege: 'La valorizacion de la degradacion es un exito se dio con exito.'
    })
    // eslint-disable-next-line no-useless-return
    return
  }

  async verifiEscalDegrad (req, res, valorDegrad = 0) {
    const rangeValori = await objescalDegrad.list_escaladegrad(req, res)
    const itemvalor = rangeValori.filter((item) => {
      const filterRange = item.rangeValid.split(' - ').map((item) => { return parseInt(item) })
      // console.log(`${(filterRange[0] <= valorAcivCualit)} && ${(filterRange[1] >= valorAcivCualit)} = ${(filterRange[0] <= valorAcivCualit) && (filterRange[1] >= valorAcivCualit)}`)
      // console.log(`${filterRange[0]} <= ${valorAcivCualit}  && ${filterRange[1]} >= ${valorAcivCualit} = ${(filterRange[0] <= valorAcivCualit) && (filterRange[1] >= valorAcivCualit)}`)
      return (filterRange[0] <= valorDegrad) && (filterRange[1] >= valorDegrad)
    })
    return itemvalor[0]
  }

  async list_valAfectAmenDimen (req, res) {
    const result = await objvaloriAmenasDim.list_valAfectAmenDimen(req, res)
    res.json(result)
  }

  extraer_key_impacto (listScale = [], valueimpact = 0) {
    const rangeValori = listScale
    const itemvalor = rangeValori.filter((item) => {
      const filterRange = item.rangeValid.split(' - ').map((item) => { return parseInt(item) })
      return (filterRange[0] <= valueimpact) && (filterRange[1] >= valueimpact)
    })
    return itemvalor[0]
  }

  extraer_key_riesgo (listScale = [], valueriesgo = 0) {
    const rangeValori = listScale
    const itemvalor = rangeValori.filter((item) => {
      const filterRange = item.rangeValid.split(' - ').map((item) => { return parseInt(item) })
      return (filterRange[0] <= valueriesgo) && (filterRange[1] >= valueriesgo)
    })
    return itemvalor[0]
  }

  async cargar_valorizacionRiesgo (req, res) {
    // cargar valorizacion generarl
    await objvaloriAmenas.loadProm_valorAfectAmen(req, res, req.body.id_valorAfectAmen)
    // cargar la valorizacion del riesgos cuatitativo
    const listValAfectAmenDimen = await objvaloriAmenasDim.list_valAfectAmenDimen(req, res, req.body.id_valorAfectAmen)
    // extraer la informacion de la afectacion de la amenaza
    const listAmenasActiv = await objvaloriAmenas.read_valorafectamen(req, res, req.body.id_valorAfectAmen)
    if (listAmenasActiv.length === 0) {
      // res.send()
      return {
        status: 404,
        typo: 'error',
        messege: 'No se a realizado la valorizacion de esta amenaza.'
      }
    }
    const idAmenaza = listAmenasActiv[0]
    // extraer informacion de la amenaza
    const listAmenas = await objafectaactiv.read_afectaactiv(req, res, idAmenaza.id_afectaActiv)
    if (listAmenas.length === 0) {
      // res.send()
      return {
        status: 404,
        typo: 'error',
        messege: 'No se a designado la amenasa al activo al que se desea valorizar.'
      }
    }
    const objAmen = listAmenas[0]
    // extraer la valorizacion del activo
    const listvalActivGen = await objvaloriActiv.list_valoractiv(req, res, objAmen.id_activProsVerAnali)
    if (listvalActivGen.length === 0) {
      // res.send()
      return {
        status: 404,
        typo: 'error',
        messege: 'No se a realizado una valorizacion de los activos de manera cuantitativa.'
      }
    }
    const objvalActivGen = listvalActivGen[0]
    // console.log(objvalActivGen)
    const listActivos = await objvaloriActivDim.list_valoriActivDimen(req, res, objvalActivGen.id_valorActiv)
    if (listActivos.length === 0) {
      // res.send()
      return {
        status: 404,
        typo: 'error',
        messege: 'No se a realizado una valorizacion de los activos por dimencion.'
      }
    }
    // -------------------------------------------------------------------------------------------- Calcular el impacto
    const listkeyImpact = await objescalImpac.list_escalaimpacto(req, res)
    const calcuImpact = listValAfectAmenDimen.map((item) => {
      // extraer la valorizacin del activo
      // console.log('lista de valorizacion de activos:', listActivos)
      const objItems = { ...item }
      // console.log(objItems)
      const listValori = listActivos.filter((valActiv) => {
        return parseInt(valActiv.id_dimension) === parseInt(objItems.id_dimension)
      })
      // si la valorizacion del activo existe, se podra realizar el calculo, sino no
      if (listValori.length !== 0) {
        // console.log(listValori)
        const objValori = listValori[0]
        // calcular el impacto
        // console.log(objValori)
        const valorImpact = Math.round(parseInt(parseInt(objValori.valorAcivCualit) * (parseInt(item.valorDegrad) / 100)))
        objItems.valorImpacto = valorImpact
        objItems.id_escaleImpac = this.extraer_key_impacto(listkeyImpact, valorImpact).id_escaleImpac
        return objItems
      }
      return objItems
    })
    // -------------------------------------------------------------------------------------------- Calcular el riesgo
    const listkeyRiesgo = await objescalRiesgo.list_escalRiesgo(req, res)
    const listkeyFreg = await objescalFrecuen.list_escalafrecuencia(req, res)
    const calcuRiesgo = calcuImpact.map((item) => {
      // extraer la valorizacin del activo
      const objItems = { ...item }
      const listkeyFregFil = listkeyFreg.filter((esclFreg) => {
        return parseInt(esclFreg.id_escalaFrecuenc) === parseInt(idAmenaza.id_escalaFrecuen)
      })
      // si la valorizacion la frecuencia existe, se podra realizar el calculo del riesgo
      if (listkeyFregFil.length !== 0) {
        const objkeyFreg = listkeyFregFil[0]
        // calcular el riesgo
        const valorRiesgo = objItems.valorImpacto * objkeyFreg.valueCuali
        objItems.valNivelRiesgo = valorRiesgo
        objItems.id_escalRiesgo = this.extraer_key_riesgo(listkeyRiesgo, valorRiesgo).id_escalRiesgo
        return objItems
      }
      return objItems
    })
    // -------------------------------------------------------------------------------------------- Insertar/actualiza a la base de datos
    for (let index = 0; index < calcuRiesgo.length; index++) {
      const element = calcuRiesgo[index]
      // console.log(element)
      await objvaloriAmenasDim.loadProm_valorAfectAmenDim(req, res, true, element)
    }
    // --------------------------------------------------------------------------------------------
    // eslint-disable-next-line no-useless-return
    return {
      status: 200,
      typo: 'succes',
      messege: 'Se cargo los calculos del riesgos y la valorizacion.'
    }
  }
}
