/* eslint-disable multiline-ternary */
const Dbcone = require('../../../config/bd/connet_mysql')
const conexibd = new Dbcone()
// ######################### DbclientAnali ###################################
module.exports = class Dbafectaactiv {
  async inser_afectaactiv (req, res, isobjData = false, objData = { idActivProsVerAnali: 0, idAmenaza: 0 }) {
    console.log(objData)
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `insert_afectaactiv`(?,?);',
      (isobjData) ? [
        objData.idActivProsVerAnali,
        objData.idAmenaza
      ] : [
        req.body.id_activProsVerAnali,
        req.body.id_amenaza
      ],
      'Se inserto correctamente el enlace por la amenaza'
    )
    return results
  }

  async delete_afectaactiv (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `delete_afectaactiv`( ? );',
      [
        req.params.id_afectaActiv
      ],
      'Se elimino correctamente el empresa'
    )
    return results
  }

  async list_afectaactiv (req, res, idActivProsVerAnali = 0) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `list_afectaactiv`(?);',
      [(parseInt(idActivProsVerAnali) === 0) ? req.params.id_activProsVerAnali : idActivProsVerAnali]
    )
    return Array.isArray(results) ? results : []
  }
}
