const BdvaloriAmenas = require('../../model/v2/valoriAmenas.bd')
const objvaloriAmenas = new BdvaloriAmenas()
const NegversionAnalisis = require('./versionanali.negocio')
const ObjversionAnalisis = new NegversionAnalisis()
const NegvaloriAmenasDim = require('./valoriAmenasDim.negocio')
const objvaloriAmenasDim = new NegvaloriAmenasDim()
const Negactivprocesanali = require('./activprocesanali.negocio')
const objactivprocesanali = new Negactivprocesanali()
const Negafectaactiv = require('./afectaactiv.negocio')
const objafectaactiv = new Negafectaactiv()
const Negproceempresa = require('./proceempresa.negocio')
const objproceempresa = new Negproceempresa()

async function validarValoriAmenaz (req, res, idAfectaActiv) {
  // comprobar la informacion de la valoriazion de la amenaza
  const listResult = await objvaloriAmenas.list_valorafectamen(req, res, idAfectaActiv)
  console.log(listResult)
  if (parseInt(listResult.length) === 0) return false
  const objResul = listResult[0]
  // comprobar la valorizacion final
  const resulComprueb = await objvaloriAmenasDim.compruebeExistenValori(req, res, objResul.id_valorAfectAmen)
  console.log(resulComprueb)
  return resulComprueb.data
}

module.exports = class ngvaloriActiv {
  async compruebeExistenValori (req, res) {
    const result = await validarValoriAmenaz(req, res, req.body.id_afectaActiv)
    // // eslint-disable-next-line no-useless-return
    return {
      status: (result) ? 200 : 404,
      typo: (result) ? 'succes' : 'error',
      messege: (result) ? 'La valorizacion de la amenaza puede ser ingresado.' : 'La valorizacion no puede ser insertada',
      data: result
    }
  }

  async insert_valorafectamen (req, res) {
    // validar si se inserto los datos de la valorizacion del activo
    const resultData = await this.compruebeExistenValori(req, res, req.body.id_afectaActiv)
    if (resultData.data) {
      res.send(resultData)
      return
    }
    // se realiza la insercion de la valorizacion de forma generica
    const result = await objvaloriAmenas.insert_valorafectamen(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }

  async actualizar_valorafectamen (req, res) {
    // validar datos insertados
    // si todo esta correcto, inserta los datos
    const result = await objvaloriAmenas.actualizar_valorafectamen(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }

  async list_valorafectamen (req, res) {
    const result = await objvaloriAmenas.list_valorafectamen(req, res)
    res.json(result)
  }

  async criticiAmenasProces (req, res, idProce = -1) {
    const idProceso = (parseInt(idProce) === -1) ? req.params.id_proceso : idProce
    // versiones de analisisi
    const resultVersion = await ObjversionAnalisis.list_versionanali(req, res, idProceso)
    // console.log(resultVersion)
    if (parseInt(resultVersion.length) === 0) {
      // si no existe ninguna version de analisis
      return '??'
    }
    // realizacion del analisisi si la version no tiene activos, o no esta valorizado, la valorizacion es ??
    const resultAnalitic = await Promise.all(resultVersion.map(async (itme) => {
      // capturamos la version
      const version = { ...itme }
      // capturar la informacion de los activos de version
      const dataActivAnali = await objactivprocesanali.list_activprosveranali(req, res, version.id_versionAnali)
      if (parseInt(dataActivAnali.length) === 0) return 0
      // capturar las amenazas con la valorizaciond e cada activo
      const dataValorizeActiv = await Promise.all(dataActivAnali.map(async (item2) => {
        // capturando las amenazas
        const itemActivAnali = { ...item2 }
        const dataAmenas = await objafectaactiv.list_afectaactiv(req, res, itemActivAnali.id_activProsVerAnali)
        // console.log(dataAmenas)
        if (dataAmenas.length === 0) {
          // console.log(0)
          return 0
        }
        const valorlistamen = dataAmenas.map((item) => {
          return (!isNaN(item.valRiesgoCualit) && item.valRiesgoCualit != null) ? item.valRiesgoCualit : 0
        })
        // console.log(valorlistamen)
        // console.log(Math.max(...valorlistamen))
        return Math.max(...valorlistamen)
      }))
      // console.log(' version - ', version.abreb, ' ', version.id_versionAnali)
      // console.log(dataValorizeActiv)
      // console.log(Math.max(...dataValorizeActiv))
      return Math.max(...dataValorizeActiv)
    }))
    const resultAnali = resultAnalitic.filter((item) => {
      return parseInt(item) !== 0
    })
    if (parseInt(resultAnali.length) === 0) return '??'
    return resultAnali[resultAnali.length - 1]
  }

  async list_criticiAmenasProces (req, res) {
    const idEmpresa = req.params.id_empresa
    const procesosEmpres = await objproceempresa.list_proceempresa(req, res, idEmpresa)
    // Listar criticidad de un proceso
    const information = await Promise.all(procesosEmpres.map(async (item) => {
      const items = { ...item }
      items.valorProces = await this.criticiAmenasProces(req, res, items.id_proceso)
      return items
    }))
    return res.json(information)
    // const valorProces = await this.criticiAmenasProces(req, res, idProceso)
    // return res.json(valorProces)
  }

  // async eliminar_areasempresa (req, res) {
  //   const result = await objareasempresa.eliminar_areasempresa(req, res)
  //   res.json(result)
  // }
}
