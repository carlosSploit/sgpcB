const Bdareainterproce = require('../../model/v2/areainterproce.bd')
const objareainterproce = new Bdareainterproce()

module.exports = class ngclienAnalit {
  async inser_areainterproce (req, res) {
    // validar datos insertados

    const result = await objareainterproce.inser_areainterproce(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }

  async list_areainterproce (req, res) {
    const result = await objareainterproce.list_areainterproce(req, res)
    res.json(result)
  }

  // async eliminar_resposproce (req, res) {
  //   const result = await objresposproce.eliminar_resposproce(req, res)
  //   res.json(result)
  // }
}
