const Dbcone = require('../../../config/bd/connet_mysql')
const conexibd = new Dbcone()
// ######################### DbclientAnali ###################################
module.exports = class Dbescalarpo {
  async list_escalarpo (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `list_escalarpo`();',
      []
    )
    return Array.isArray(results) ? results : []
  }
}
