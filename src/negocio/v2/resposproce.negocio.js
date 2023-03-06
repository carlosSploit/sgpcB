const Bdresposproce = require('../../model/v2/resposproce.bd')
const objresposproce = new Bdresposproce()

const valideInserResonRepit = async (req, res) => {
  try {
    const idProceso = req.body.id_proceso
    const idTrabajador = req.body.id_trabajador
    const resultCom = await objresposproce.list_resposproce(req, res, idProceso)
    const filterData = resultCom.filter((item) => {
      return parseInt(item.Id_trabajador) === parseInt(idTrabajador)
    })
    return filterData.length > 0
  } catch (error) {
    return true
  }
}

module.exports = class ngclienAnalit {
  async inser_resposproce (req, res) {
    // validar datos insertados
    const resulValid = await valideInserResonRepit(req, res)

    if (resulValid) {
      res.send({
        status: 404,
        typo: 'error',
        messege: 'El area ya fue designado al proceso.',
        data: []
      })
      return
    }

    const result = await objresposproce.inser_resposproce(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }

  async list_areasempresa (req, res) {
    const result = await objresposproce.list_resposproce(req, res)
    res.json(result)
  }

  async eliminar_resposproce (req, res) {
    const result = await objresposproce.eliminar_resposproce(req, res)
    res.json(result)
  }
}
