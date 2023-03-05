const Dbcone = require('../../../config/bd/connet_mysql')
const conexibd = new Dbcone()
// ######################### DbclientAnali ###################################
module.exports = class DbtipProce {
  async list_tipProce (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `list_tipProce`();',
      []
    )
    return Array.isArray(results) ? results : []
  }
}
