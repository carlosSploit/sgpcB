const Dbcone = require('../../../config/bd/connet_mysql')
const conexibd = new Dbcone()
// ######################### DbclientAnali ###################################
module.exports = class Dbactivproces {
  async insert_afecactivinsiden (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `insert_afecactivinsiden`(?,?);',
      [
        req.body.id_afectaActiv,
        req.body.id_insidencia
      ],
      'Se enlazo correctamente la insidencia con la amenaza'
    )
    return results
  }

  async eliminar_afecactivinsiden (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `delete_afecactivinsiden`( ? );',
      [
        req.params.id_afectaActivInsid
      ],
      'Se elimino correctamente el empresa'
    )
    return results
  }

  async list_afecactivinsiden (req, res, idAfectaActiv = -1) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `list_afecactivinsiden`(?);',
      [(parseInt(idAfectaActiv) === -1) ? req.params.id_afectaActiv : idAfectaActiv]
    )
    return Array.isArray(results) ? results : []
  }
// eslint-disable-next-line eol-last
}