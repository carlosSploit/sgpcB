const Dbcone = require('../../../config/bd/connet_mysql')
const conexibd = new Dbcone()
// ######################### DbclientAnali ###################################
module.exports = class Dbresposproce {
  async inser_resposproce (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `insert_resposproce`(?,?);',
      [
        req.body.id_trabajador,
        req.body.id_proceso
      ],
      'Se inserto correctamente la empresa'
    )
    return results
  }

  async eliminar_resposproce (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `delete_resposproce`( ? );',
      [
        req.params.id_areempre
      ],
      'Se elimino correctamente el empresa'
    )
    return results
  }

  async list_resposproce (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `list_resposproce`(?);',
      [req.params.id_proceso]
    )
    return Array.isArray(results) ? results : []
  }
}
