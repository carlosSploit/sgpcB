const Dbcone = require('../../../config/bd/connet_mysql')
const conexibd = new Dbcone()
// ######################### DbclientAnali ###################################
module.exports = class Dbactivproces {
  async inser_activproces (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `insert_activproces`(?,?);',
      [
        req.body.id_proceso,
        req.body.id_activo
      ],
      'Se inserto correctamente la empresa'
    )
    return results
  }

  async eliminar_activproces (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `delete_activproces`( ? );',
      [
        req.params.id_activproc
      ],
      'Se elimino correctamente el empresa'
    )
    return results
  }

  async list_activproces (req, res, idProceso = -1) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `list_activproces`(?);',
      [(parseInt(idProceso) === -1) ? req.params.id_proceso : idProceso]
    )
    return Array.isArray(results) ? results : []
  }
// eslint-disable-next-line eol-last
}