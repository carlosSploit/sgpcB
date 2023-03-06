const BdtipoActiv = require('../../model/v2/tipoActiv.bd')
const objtipoActiv = new BdtipoActiv()

module.exports = class ngclienAnalit {
  async inser_tipoActiv (req, res) {
    const result = await objtipoActiv.inser_tipoActiv(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }

  async list_tipoActiv (req, res) {
    const result = await objtipoActiv.list_tipoActiv(req, res)
    res.json(result)
  }

  // async eliminar_areainterproce (req, res) {
  //   const result = await objareainterproce.eliminar_areainterproce(req, res)
  //   res.json(result)
  // }
}
