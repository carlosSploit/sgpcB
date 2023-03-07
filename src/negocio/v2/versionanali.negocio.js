const Bdversionanali = require('../../model/v2/versionanali.bd')
const objversionanali = new Bdversionanali()

module.exports = class ngversionanali {
  async inser_versionanali (req, res) {
    const result = await objversionanali.inser_versionanali(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }

  async list_versionanali (req, res) {
    const result = await objversionanali.list_versionanali(req, res)
    res.json(result)
  }

  // async eliminar_areainterproce (req, res) {
  //   const result = await objareainterproce.eliminar_areainterproce(req, res)
  //   res.json(result)
  // }
}
