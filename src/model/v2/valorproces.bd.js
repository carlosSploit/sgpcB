const Dbcone = require('../../../config/bd/connet_mysql')
const conexibd = new Dbcone()
// ######################### DbclientAnali ###################################
module.exports = class Dbproceempresa {
  async actualise_valorproces (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `update_valorproces`(?,?,?,?);',
      [
        req.body.id_escalaRTO,
        req.body.id_escalaRPO,
        req.body.valorMDT,
        req.params.id_valorProc
      ],
      'Se actualizo correctamente la valorizacion del proceso'
    )
    return results
  }

  async read_valorproces (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `read_valorproces`(?);',
      [
        req.params.id_proceso
      ]
    )
    return Array.isArray(results) ? results : []
  }
}
