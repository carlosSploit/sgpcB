const Dbcone = require('../../../config/bd/connet_mysql')
const conexibd = new Dbcone()
// ######################### DbclientAnali ###################################
module.exports = class Dbareasempresa {
  async inser_areasempresa (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `insert_areasempresa`(?,?,?);',
      [
        req.body.nombrearea,
        req.body.descriparea,
        req.body.id_empresa
      ],
      'Se inserto correctamente la empresa'
    )
    return results
  }

  async actualise_areasempresa (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `update_areasempresa`(?,?,?);',
      [
        req.body.nombrearea,
        req.body.descriparea,
        req.params.id_areempre
      ],
      'Se actualizo correctamente el empresa'
    )
    return results
  }

  async eliminar_areasempresa (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `delete_areasempresa`( ? );',
      [
        req.params.id_areempre
      ],
      'Se elimino correctamente el empresa'
    )
    return results
  }

  async list_areasempresa (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `list_areasempresa`(?);',
      [req.params.id_empresa]
    )
    return Array.isArray(results) ? results : []
  }
}
