const BdresponAnalisis = require('../../model/v2/responAnalisis.bd')
const objresponAnalisis = new BdresponAnalisis()

const valideInserResonRepit = async (req, res) => {
  try {
    const idVersionAnali = req.body.id_versionAnali
    const idCliente = req.body.id_cliente
    const resultCom = await objresponAnalisis.list_responanalis(req, res, idVersionAnali)
    const filterData = resultCom.filter((item) => {
      return parseInt(item.id_cliente) === parseInt(idCliente)
    })
    return filterData.length > 0
  } catch (error) {
    return true
  }
}

module.exports = class ngResponanalis {
  async insert_responanalis (req, res) {
    // validar datos insertados
    console.log(req.body)
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

    const result = await objresponAnalisis.insert_responanalis(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }

  async list_responanalis (req, res) {
    const result = await objresponAnalisis.list_responanalis(req, res)
    res.json(result)
  }

  async eliminar_responanalis (req, res) {
    const result = await objresponAnalisis.eliminar_responanalis(req, res)
    res.json(result)
  }
}
