const Dbcone = require('../../../config/bd/connet_mysql')
const conexibd = new Dbcone()
// ######################### DbclientAnali ###################################
module.exports = class Dbrolrespon {
  async list_rolrespon (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `list_rolrespon`();',
      []
    )
    return Array.isArray(results) ? results : []
  }
}
