const Dbcone = require('../../../config/bd/connet_mysql')
const conexibd = new Dbcone()
// ######################### DbclientAnali ###################################
module.exports = class Dbareainterproce {
  async inser_areainterproce (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `insert_areainterproce`(?,?);',
      [
        req.body.id_areaEmpre,
        req.body.id_proceso
      ],
      'Se inserto correctamente la empresa'
    )
    return results
  }

  async eliminar_areainterproce (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `delet_areainterproce`( ? );',
      [
        req.params.id_areaProce
      ],
      'Se elimino correctamente el empresa'
    )
    return results
  }

  async list_areainterproce (req, res, idProceso = 0) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `list_areainterproce`(?);',
      [(parseInt(idProceso) === 0) ? req.params.id_proceso : idProceso]
    )
    return Array.isArray(results) ? results : []
  }
}
