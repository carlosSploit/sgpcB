// const Validator = require('../../config/complementos/validator')
// const objvalit = new Validator()
const Bdtipoconte = require('../model/bd_tipoconte')
const objcontesesion = new Bdtipoconte()

module.exports = class ngtipoconten {
  async list_tipoconte (req, res) {
    const result = await objcontesesion.list_tipoconte(req, res)
    res.json(result)
  }
}
