const Dbcone = require('../../../config/bd/connet_mysql')
const conexibd = new Dbcone()
// ######################### DbclientAnali ###################################
module.exports = class DbobjVersioAnalis {
  async insert_recurSalvAfectAct (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `insert_recurSalvAfectAct`(?,?,?,?);',
      [
        req.body.id_salvAfectAct,
        req.body.nombreRecurSalvAfect,
        req.body.descripc,
        req.body.presioRecurMitAfec
      ],
      'Se inserto correctamente el recurso para realizar la extrategia.'
    )
    return results
  }

  async actualise_recurSalvAfectAct (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `update_recurSalvAfectAct`(?,?,?,?);',
      [
        req.params.id_recurSalvAfectAct,
        req.body.nombreRecurSalvAfect,
        req.body.descripc,
        req.body.presioRecurMitAfec
      ],
      'Se actualizo correctamente el recurso para realizar la extrategia.'
    )
    return results
  }

  async eliminar_recurSalvAfectAct (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `delete_recurSalvAfectAct`( ? );',
      [
        req.params.id_recurSalvAfectAct
      ],
      'Se elimino correctamente el recurso para realizar la extrategia.'
    )
    return results
  }

  async list_recurSalvAfectAct (req, res, idSalvAfectAct = 0) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `list_recurSalvAfectAct`(?);',
      [(parseInt(idSalvAfectAct) === 0) ? req.params.id_salvAfectAct : idSalvAfectAct]
    )
    return Array.isArray(results) ? results : []
  }
}
