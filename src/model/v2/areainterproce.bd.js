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

  // async eliminar_resposproce (req, res) {
  //   const results = await conexibd.single_query(
  //     req,
  //     res,
  //     'CALL `delete_resposproce`( ? );',
  //     [
  //       req.params.id_resposProce
  //     ],
  //     'Se elimino correctamente el empresa'
  //   )
  //   return results
  // }

  async list_areainterproce (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `list_areainterproce`(?);',
      [req.params.id_proceso]
    )
    return Array.isArray(results) ? results : []
  }
}
