const Dbcone = require('../../../config/bd/connet_mysql')
const conexibd = new Dbcone()
// ######################### DbclientAnali ###################################
module.exports = class Dbareasempresa {
  async inser_objempresa (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `insert_objempresa`(?,?);',
      [
        req.body.id_empresa,
        req.body.nombreObje
      ],
      'Se inserto correctamente la empresa'
    )
    return results
  }

  async actualise_objempresa (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `update_objempresa`(?,?);',
      [
        req.body.nombreObje,
        req.params.id_objEmpresa
      ],
      'Se actualizo correctamente el empresa'
    )
    return results
  }

  async eliminar_objempresa (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `delete_objempresa`( ? );',
      [
        req.params.id_objEmpresa
      ],
      'Se elimino correctamente el empresa'
    )
    return results
  }

  async list_objempresa (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `list_objempresa`(?);',
      [req.params.id_empresa]
    )
    return Array.isArray(results) ? results : []
  }
}
