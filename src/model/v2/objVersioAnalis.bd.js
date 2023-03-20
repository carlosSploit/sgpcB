const Dbcone = require('../../../config/bd/connet_mysql')
const conexibd = new Dbcone()
// ######################### DbclientAnali ###################################
module.exports = class DbobjVersioAnalis {
  async inser_objVersioAnalis (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `insert_objversanali`(?,?);',
      [
        req.body.id_versionAnali,
        req.body.nombreObje
      ],
      'Se inserto correctamente la empresa'
    )
    return results
  }

  async actualise_objVersioAnalis (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `update_objversanali`(?,?);',
      [
        req.body.nombreObje,
        req.params.id_objVersAnali
      ],
      'Se actualizo correctamente el empresa'
    )
    return results
  }

  async eliminar_objVersioAnalis (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `delete_objversanali`( ? );',
      [
        req.params.id_objVersAnali
      ],
      'Se elimino correctamente el empresa'
    )
    return results
  }

  async list_objVersioAnalis (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `list_objversanali`(?);',
      [req.params.id_versionAnali]
    )
    return Array.isArray(results) ? results : []
  }
}
