const Dbcone = require('../../../config/bd/connet_mysql')
const conexibd = new Dbcone()
// ######################### DbclientAnali ###################################
module.exports = class Dbareasempresa {
  async list_gerarProce (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `list_gerarProce`();',
      []
    )
    return Array.isArray(results) ? results : []
  }
}
