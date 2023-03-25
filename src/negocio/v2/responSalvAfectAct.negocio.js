const BdresponSalvAfectAct = require('../../model/v2/responSalvAfectAct.bd')
const objresponSalvAfectAct = new BdresponSalvAfectAct()

const valideInserResponSalvag = async (req, res) => {
  try {
    const idSalvAfectAct = req.body.id_salvAfectAct
    const idTrabajador = req.body.id_trabajador
    const resultCom = await objresponSalvAfectAct.list_responSalvAfectAct(req, res, idSalvAfectAct)
    const filterData = resultCom.filter((item) => {
      return parseInt(item.id_trabajador) === parseInt(idTrabajador)
    })
    return filterData.length > 0
  } catch (error) {
    return true
  }
}

module.exports = class ngclienAnalit {
  async insert_responSalvAfectAct (req, res) {
    // validar datos insertados
    const resulValid = await valideInserResponSalvag(req, res)

    if (resulValid) {
      res.send({
        status: 404,
        typo: 'error',
        messege: 'El responsable ya fue designado al proceso.',
        data: []
      })
      return
    }

    const result = await objresponSalvAfectAct.insert_responSalvAfectAct(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }

  async list_responSalvAfectAct (req, res) {
    const result = await objresponSalvAfectAct.list_responSalvAfectAct(req, res)
    res.json(result)
  }

  async eliminar_responSalvAfectAct (req, res) {
    const result = await objresponSalvAfectAct.eliminar_responSalvAfectAct(req, res)
    res.json(result)
  }
}
