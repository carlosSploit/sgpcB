const Dbcone = require('../../../config/bd/connet_mysql')
const conexibd = new Dbcone()
// ######################### DbclientAnali ###################################
module.exports = class Dbresponanalis {
  async insert_responanalis (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `insert_responanalis`(?,?,?);',
      [
        req.body.id_versionAnali,
        req.body.id_cliente,
        req.body.id_rolRespon
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

  async list_responanalis (req, res, idVersionAnali = 0) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `list_responanalis`(?);',
      [(parseInt(idVersionAnali) === 0) ? req.params.id_versionAnali : idVersionAnali]
    )
    return Array.isArray(results) ? results : []
  }
}
