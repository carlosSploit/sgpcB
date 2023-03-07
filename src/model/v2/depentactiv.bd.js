const Dbcone = require('../../../config/bd/connet_mysql')
const conexibd = new Dbcone()
// ######################### DbclientAnali ###################################
module.exports = class Dbdepentactiv {
  async inser_depentactiv (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `insert_depentactiv`(?,?);',
      [
        req.body.id_activProc,
        req.body.id_depActiv
      ],
      'Se inserto correctamente la empresa'
    )
    return results
  }

  async eliminar_depentactiv (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `delete_depentactiv`( ? );',
      [
        req.params.id_depenActiv
      ],
      'Se elimino correctamente el empresa'
    )
    return results
  }

  async list_depentactiv (req, res, idactivproc = 0) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `list_depentactiv`(?);',
      [(parseInt(idactivproc) === 0) ? req.params.id_activproc : idactivproc]
    )
    return Array.isArray(results) ? results : []
  }
}
