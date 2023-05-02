// const Validator = require('../../../config/complementos/validator')
// const objvalit = new Validator()
const Bdversionanali = require('../../model/v2/versionanali.bd')
const objversionanali = new Bdversionanali()
const Bdareainterproce = require('../../model/v2/areainterproce.bd')
const objareainterproce = new Bdareainterproce()
const Bdresposproce = require('../../model/v2/resposproce.bd')
const objresposproce = new Bdresposproce()
const Bdactivprocesanali = require('../../model/v2/activprocesanali.bd')
const objactivprocesanali = new Bdactivprocesanali()
const Bdafectaactiv = require('../../model/v2/afectaactiv.bd')
const objafectaactiv = new Bdafectaactiv()
const Bdafecactivinsiden = require('../../model/v2/afecactivinsiden.bd')
const objafecactivinsiden = new Bdafecactivinsiden()
const BdresponSalvAfectAct = require('../../model/v2/responSalvAfectAct.bd')
const objresponSalvAfectAct = new BdresponSalvAfectAct()
const BdrecurSalvAfectAct = require('../../model/v2/recurSalvAfectAct.bd')
const objrecurSalvAfectAct = new BdrecurSalvAfectAct()
const Negsalvafectact = require('../v2/salvafectact.negocio')
const objnegsalvafectact = new Negsalvafectact()
const NegvalorSalvAfectAct = require('../v2/valorSalvAfectAct.negocio')
const objnegvalorSalvAfectAct = new NegvalorSalvAfectAct()
const NegvaloriAmenas = require('./valoriAmenas.negocio')
const objvaloriAmenas = new NegvaloriAmenas()
// const Negafectaactiv = require('../v2/afectaactiv.negocio')
// const objnegafectaactiv = new Negafectaactiv()

// const Valideinsert = (req) => {
//   const valida =
//     objvalit.validator_vacio(req.body.nombre_Activo) ||
//     objvalit.validator_vacio(req.body.descripc)

//   const dataarray = [
//     {
//       datacom: 'nombre_Activo',
//       valide: objvalit.validator_vacio(req.body.nombre_Activo)
//     },
//     {
//       datacom: 'descripc',
//       valide: objvalit.validator_vacio(req.body.descripc)
//     }
//   ]

//   const auxvalidetdata = dataarray.filter((item) => {
//     return item.valide
//   })
//   console.log(auxvalidetdata)
//   return { valida, auxvalidetdata }
// }

module.exports = class NegPlanesContingencias {
  // async inser_activo (req, res) {
  //   // validar datos insertados
  //   const validado = Valideinsert(req)

  //   if (validado.valida) {
  //     res.send({
  //       status: 404,
  //       typo: 'error',
  //       messege: 'Casillas mal ingresadas',
  //       data: validado.auxvalidetdata
  //     })
  //     // eslint-disable-next-line no-useless-return
  //     return
  //   }

  //   const result = await objactivos.inser_activo(req, res)
  //   res.send({
  //     status: 200,
  //     typo: 'succes',
  //     messege: result
  //   })
  // }

  // async actualise_activos (req, res) {
  //   // validar datos insertados
  //   const validado = Valideinsert(req)

  //   if (validado.valida) {
  //     res.send({
  //       status: 404,
  //       typo: 'error',
  //       messege: 'Casillas mal ingresadas',
  //       data: validado.auxvalidetdata
  //     })
  //     // eslint-disable-next-line no-useless-return
  //     return
  //   }

  //   // si todo esta correcto, inserta los datos
  //   const result = await objactivos.actualise_activos(req, res)
  //   res.send({
  //     status: 200,
  //     typo: 'succes',
  //     messege: result
  //   })
  // }

  async list_activos (req, res) {
    // capturar la informacion de las versiones
    const result = await objversionanali.list_versionanali(req, res)
    res.json(result)
  }

  async imformationAmenaz (req, res) {
    const idActivProsVerAnali = req.params.id_activProsVerAnali
    const idAfectaActiv = req.params.id_afectaActiv
    // ---------------------------------------------------------------------- capturar la informacion de la amenaza
    const result = await objafectaactiv.list_afectaactiv(req, res, idActivProsVerAnali)
    // console.log(result)
    const listResult = result.filter((item) => {
      return parseInt(item.id_afectaActiv) === parseInt(idAfectaActiv)
    })
    if (parseInt(listResult.length) === 0) return res.send([])
    const objJson = { ...listResult[0] }
    // capturar de las insidencias - debe darse por la lista de insidencias
    const resultInsiden = await objafecactivinsiden.list_afecactivinsiden(req, res, objJson.id_afectaActiv)
    objJson.insidenAline = resultInsiden
    // capturar de las salvaguardas
    const resulSalvagurd = await objnegsalvafectact.list_salvAfectAct(req, res, objJson.id_afectaActiv)
    // hacer una recarga de datos
    const listValorize = resulSalvagurd.filter((item) => {
      return (!((parseInt(item.valEficDegr) === 0) && (parseInt(item.valEficFrec) === 0) && (parseInt(item.valEficImpac) === 0)))
    })
    console.log(listValorize)
    for (let index = 0; index < listValorize.length; index++) {
      const element = listValorize[index]
      await objnegvalorSalvAfectAct.cagarInforValorizacion(req, res, element.id_salvAfectAct)
    }
    // volver a cargar las salvaguardas
    const resulSalvagurd2 = await objnegsalvafectact.list_salvAfectAct(req, res, objJson.id_afectaActiv)
    // captuar los recursos y los responsables
    const resulSalvagurdRespoRecurs = await Promise.all(
      resulSalvagurd2.map(async (item) => {
        const objJsonSalv = { ...item }
        // capturar los responsables de las salvaguardas
        const listResponSalvagu = await objresponSalvAfectAct.list_responSalvAfectAct(req, res, objJsonSalv.id_salvAfectAct)
        objJsonSalv.responSalvagu = listResponSalvagu
        // capturar los recursos de las salvaguardas
        const listRecursSalvagu = await objrecurSalvAfectAct.list_recurSalvAfectAct(req, res, objJsonSalv.id_salvAfectAct)
        objJsonSalv.recursSalvagu = listRecursSalvagu
        return objJsonSalv
      })
    )
    objJson.salvagAfect = resulSalvagurdRespoRecurs
    res.send(objJson)
  }

  async informationProces (req, res) {
    // ---------------------------------------------------------------------- capturar la informacion de la version y el proceso
    const idVersionAnalitic = req.params.id_versionAnalitic
    const result = await objversionanali.read_versionanali(req, res, idVersionAnalitic)
    if (parseInt(result.length) === 0) return []
    const objJson = { ...result[0] }
    // capturar informacion de su criticidad
    const resulCritc = await objvaloriAmenas.criticiAmenasProces(req, res, objJson.id_proceso)
    objJson.valorProcesCritis = resulCritc
    // capturar informacion de las areas
    const resultAreas = await objareainterproce.list_areainterproce(req, res, objJson.id_proceso)
    objJson.areasInterac = resultAreas
    // capturar los responsables del proceso
    const resultRespom = await objresposproce.list_resposproce(req, res, objJson.id_proceso)
    objJson.respoProces = resultRespom
    // capturar la informacion de los activos a analizar
    const resultActivAnalize = await objactivprocesanali.list_activprosveranali(req, res, idVersionAnalitic)
    // capturar las amenazas por cada uno de los activos de analisis
    const resultAmenazAndActiv = await Promise.all(
      resultActivAnalize.map(async (item) => {
        const objJsonActi = { ...item }
        const listAmenas = await objafectaactiv.list_afectaactiv(req, res, objJsonActi.id_activProsVerAnali)
        objJsonActi.amenasDetect = listAmenas
        return objJsonActi
      })
    )
    objJson.activAnalit = resultAmenazAndActiv
    res.json(objJson)
  }
}
