const Dbcone = require('../../../config/bd/connet_mysql')
const conexibd = new Dbcone()
// ######################### DbclientAnali ###################################
module.exports = class DbclientAnali {
  async inser_insidencia (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `insert_inisiden`(?,?,?,?);',
      [
        req.body.id_activProc,
        req.body.id_amenaza,
        req.body.nombreInsid,
        req.body.descrpInsid
      ],
      'Se inserto correctamente la insidencia'
    )
    return results
  }

  async actualise_insidencias (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `update_insidencias`(?,?,?,?,?);',
      [
        req.params.id_insidencia,
        req.body.id_activProc,
        req.body.id_amenaza,
        req.body.nombreInsid,
        req.body.descrpInsid
      ],
      'Se actualizo correctamente la insidencia'
    )
    return results
  }

  async list_insidencias (req, res, idProces = -1) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `list_insidencias`(?);',
      (parseInt(idProces) === -1) ? [req.params.id_proceso] : [idProces]
    )
    return Array.isArray(results) ? results : []
  }

  async delete_insidencias (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `delete_insidencias`(?);',
      [req.params.id_insidencia],
      'Se elimino correctamente la insidencia.'
    )
    return results
  }

  // async read_clienAnalit (req, res) {
  //   const results = await conexibd.single_query(
  //     req,
  //     res,
  //     'CALL `read_clientAnali`(?);',
  //     [req.params.id_clienAnalit]
  //   )
  //   return Array.isArray(results) ? results : []
  // }
}
