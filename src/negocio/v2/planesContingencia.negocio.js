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

  async informationProces (req, res) {
    // ---------------------------------------------------------------------- capturar la informacion de la version y el proceso
    const idVersionAnalitic = req.params.id_versionAnalitic
    const result = await objversionanali.read_versionanali(req, res, idVersionAnalitic)
    if (parseInt(result.length) === 0) return []
    const objJson = { ...result[0] }
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
