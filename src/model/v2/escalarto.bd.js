const Dbcone = require('../../../config/bd/connet_mysql')
const conexibd = new Dbcone()
// ######################### DbclientAnali ###################################
module.exports = class Dbescalarto {
  async list_escalarto (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `list_escalarto`();',
      []
    )
    return Array.isArray(results) ? results : []
  }
}
