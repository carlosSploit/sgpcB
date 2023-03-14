const Bdversionanali = require('../../model/v2/versionanali.bd')
const objversionanali = new Bdversionanali()
const Bdactivproces = require('../../model/v2/activproces.bd')
const objactivproces = new Bdactivproces()
module.exports = class ngversionanali {
  async inser_versionanali (req, res) {
    // comprobar si hay activos en el proceso
    const resulLisAct = await objactivproces.list_activproces(req, res, req.body.id_proceso)
    if (resulLisAct.length === 0) {
      res.send({
        status: 404,
        typo: 'error',
        messege: 'El proceso no presenta activos enlazados, porfavor enlaza activos.'
      })
      return
    }
    // se inserta una version del activo
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

  async eliminar_versionanali (req, res) {
    const result = await objversionanali.eliminar_versionanali(req, res)
    res.json(result)
  }
}
