const Bdareainterproce = require('../../model/v2/areainterproce.bd')
const objareainterproce = new Bdareainterproce()

const valideInserAreaRepit = async (req, res) => {
  try {
    const idProceso = req.body.id_proceso
    const idAreaEmpre = req.body.id_areaEmpre
    const resultCom = await objareainterproce.list_areainterproce(req, res, idProceso)
    const filterData = resultCom.filter((item) => {
      return parseInt(item.id_areempre) === parseInt(idAreaEmpre)
    })
    return filterData.length > 0
  } catch (error) {
    return true
  }
}

module.exports = class ngclienAnalit {
  async inser_areainterproce (req, res) {
    // validar datos insertados
    const resulValid = await valideInserAreaRepit(req, res)

    if (resulValid) {
      res.send({
        status: 404,
        typo: 'error',
        messege: 'El area ya fue designado al proceso.',
        data: []
      })
      return
    }

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

  async eliminar_areainterproce (req, res) {
    const result = await objareainterproce.eliminar_areainterproce(req, res)
    res.json(result)
  }
}
