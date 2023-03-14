const BdcriteriosValori = require('../../model/v2/criteriosValori.bd')
const objcriteriosValori = new BdcriteriosValori()

module.exports = class ngdimensionanalisis {
  async inser_criteriosValori (req, res) {
    const result = await objcriteriosValori.inser_criteriosValori(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }

  async list_criteriosValori (req, res) {
    const result = await objcriteriosValori.list_criteriosValori(req, res)
    res.json(result)
  }

  // async eliminar_areainterproce (req, res) {
  //   const result = await objareainterproce.eliminar_areainterproce(req, res)
  //   res.json(result)
  // }
}
