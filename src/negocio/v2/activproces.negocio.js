const Bdactivproces = require('../../model/v2/activproces.bd')
const objactivproces = new Bdactivproces()

const valideInserActivRepit = async (req, res) => {
  try {
    const idProceso = req.body.id_proceso
    const idActivo = req.body.id_activo
    const resultCom = await objactivproces.list_activproces(req, res, idProceso)
    const filterData = resultCom.filter((item) => {
      return parseInt(item.id_activo) === parseInt(idActivo)
    })
    return filterData.length > 0
  } catch (error) {
    return true
  }
}

module.exports = class ngclienAnalit {
  async inser_activproces (req, res) {
    // validar datos insertados
    const resulValid = await valideInserActivRepit(req, res)

    if (resulValid) {
      res.send({
        status: 404,
        typo: 'error',
        messege: 'El activo ya fue designado al proceso.',
        data: []
      })
      return
    }

    const result = await objactivproces.inser_activproces(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }

  async list_activproces (req, res) {
    const result = await objactivproces.list_activproces(req, res)
    res.json(result)
  }

  async eliminar_activproces (req, res) {
    const result = await objactivproces.eliminar_activproces(req, res)
    res.json(result)
  }
}
