const Bdnivelvalor = require('../../model/v2/nivelvalor.bd')
const objnivelvalor = new Bdnivelvalor()

module.exports = class ngdimensionanalisis {
  // async inser_tipocritervalor (req, res) {
  //   const result = await objtipocritevalor.inser_tipocritervalor(req, res)
  //   res.send({
  //     status: 200,
  //     typo: 'succes',
  //     messege: result
  //   })
  // }

  async list_nivelvalor (req, res) {
    const result = await objnivelvalor.list_nivelvalor(req, res)
    res.json(result)
  }

  // async eliminar_areainterproce (req, res) {
  //   const result = await objareainterproce.eliminar_areainterproce(req, res)
  //   res.json(result)
  // }
}
