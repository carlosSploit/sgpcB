const Validator = require('../../../config/complementos/validator')
const objvalit = new Validator()
const BdrecurSalvAfectAct = require('../../model/v2/recurSalvAfectAct.bd')
const objrecurSalvAfectAct = new BdrecurSalvAfectAct()

const Valideinsert = (req) => {
  const valida =
    objvalit.validator_vacio(req.body.nombreRecurSalvAfect) ||
    objvalit.validator_vacio(req.body.descripc) ||
    objvalit.validator_decimal(req.body.presioRecurMitAfec)

  const dataarray = [
    {
      datacom: 'nombreRecurSalvAfect',
      valide: objvalit.validator_vacio(req.body.nombreRecurSalvAfect)
    },
    {
      datacom: 'descripc',
      valide: objvalit.validator_vacio(req.body.descripc)
    },
    {
      datacom: 'presioRecurMitAfec',
      valide: objvalit.validator_decimal(req.body.presioRecurMitAfec)
    }
  ]

  const auxvalidetdata = dataarray.filter((item) => {
    return item.valide
  })
  return { valida, auxvalidetdata }
}

module.exports = class ngclienAnalit {
  async insert_recurSalvAfectAct (req, res) {
    // validar datos insertados
    const validado = Valideinsert(req)

    if (validado.valida) {
      res.send({
        status: 404,
        typo: 'error',
        messege: 'Casillas mal ingresadas',
        data: validado.auxvalidetdata
      })
      // eslint-disable-next-line no-useless-return
      return
    }

    const result = await objrecurSalvAfectAct.insert_recurSalvAfectAct(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }

  async actualise_recurSalvAfectAct (req, res) {
    // validar datos insertados
    const validado = Valideinsert(req)

    if (validado.valida) {
      res.send({
        status: 404,
        typo: 'error',
        messege: 'Casillas mal ingresadas',
        data: validado.auxvalidetdata
      })
      // eslint-disable-next-line no-useless-return
      return
    }

    // si todo esta correcto, inserta los datos
    const result = await objrecurSalvAfectAct.actualise_recurSalvAfectAct(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }

  async list_recurSalvAfectAct (req, res) {
    const result = await objrecurSalvAfectAct.list_recurSalvAfectAct(req, res)
    res.json(result)
  }

  async eliminar_recurSalvAfectAct (req, res) {
    const result = await objrecurSalvAfectAct.eliminar_recurSalvAfectAct(req, res)
    res.json(result)
  }
}
