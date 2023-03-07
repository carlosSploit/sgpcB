const Bddepentactiv = require('../../model/v2/depentactiv.bd')
const objdepentactiv = new Bddepentactiv()

const valideInserAtivRepit = async (req, res) => {
  try {
    const idActivProc = req.body.id_activProc
    const idDepActiv = req.body.id_depActiv
    const resultCom = await objdepentactiv.list_depentactiv(req, res, idActivProc)
    const filterData = resultCom.filter((item) => {
      return parseInt(item.id_depActiv) === parseInt(idDepActiv)
    })
    return filterData.length > 0
  } catch (error) {
    return true
  }
}

module.exports = class ngdepentactiv {
  async inser_depentactiv (req, res) {
    // validar datos insertados
    const resulValid = await valideInserAtivRepit(req, res)

    if (resulValid) {
      res.send({
        status: 404,
        typo: 'error',
        messege: 'El area ya fue designado al proceso.',
        data: []
      })
      return
    }

    const result = await objdepentactiv.inser_depentactiv(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }

  async list_depentactiv (req, res) {
    const result = await objdepentactiv.list_depentactiv(req, res)
    res.json(result)
  }

  async eliminar_depentactiv (req, res) {
    const result = await objdepentactiv.eliminar_depentactiv(req, res)
    res.json(result)
  }
}
