const Bdtipocritevalor = require('../../model/v2/tipocritevalor.bd')
const objtipocritevalor = new Bdtipocritevalor()

module.exports = class ngdimensionanalisis {
  async inser_tipocritervalor (req, res) {
    const result = await objtipocritevalor.inser_tipocritervalor(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }

  async list_tipocritervalort (req, res) {
    const result = await objtipocritevalor.list_tipocritervalor(req, res)
    res.json(result)
  }

  // async eliminar_areainterproce (req, res) {
  //   const result = await objareainterproce.eliminar_areainterproce(req, res)
  //   res.json(result)
  // }
}
