const Bdactivprocesanali = require('../../model/v2/activprocesanali.bd')
const objactivprocesanali = new Bdactivprocesanali()

const valideInserAreaRepit = async (req, res) => {
  try {
    const idVersonAnali = req.body.id_versonAnali
    const idActivProc = req.body.id_activProc
    const resultCom = await objactivprocesanali.list_activprosveranali(req, res, idVersonAnali)
    // console.log(resultCom)
    const filterData = resultCom.filter((item) => {
      return parseInt(item.id_activProc) === parseInt(idActivProc)
    })
    return filterData.length > 0
  } catch (error) {
    return true
  }
}

module.exports = class ngclienAnalit {
  async insert_activprosveranali (req, res) {
    const validEnlace = await valideInserAreaRepit(req, res)
    if (validEnlace) {
      res.send({
        status: 404,
        typo: 'error',
        messege: 'Error, el activo ya se esta analisando.'
      })
      return
    }

    const result = await objactivprocesanali.insert_activprosveranali(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }

  async list_activprosveranali (req, res, idVersionAnali = -1) {
    const result = await objactivprocesanali.list_activprosveranali(req, res, (parseInt(idVersionAnali) === -1) ? 0 : idVersionAnali)
    return result
  }

  async read_activprosveranali (req, res) {
    const result = await objactivprocesanali.read_activprosveranali(req, res)
    res.json(result)
  }

  async eliminar_activprosveranali (req, res) {
    const result = await objactivprocesanali.eliminar_activprosveranali(req, res)
    res.json(result)
  }
}
