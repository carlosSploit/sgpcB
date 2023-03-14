const Bddescripccion = require('../../model/v2/descripccion.bd')
const objdescripccion = new Bddescripccion()

module.exports = class ngdimensionanalisis {
  async inser_dimensionanalisis (req, res) {
    const result = await objdescripccion.inser_dimensionanalisis(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }

  async list_dimensionanalisis (req, res) {
    const result = await objdescripccion.list_dimensionanalisis(req, res)
    res.json(result)
  }

  // async eliminar_areainterproce (req, res) {
  //   const result = await objareainterproce.eliminar_areainterproce(req, res)
  //   res.json(result)
  // }
}
