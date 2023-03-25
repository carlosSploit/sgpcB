const Validator = require('../../../config/complementos/validator')
const objvalit = new Validator()
const Bdpassalvafect = require('../../model/v2/passalvafect.bd')
const objpassalvafect = new Bdpassalvafect()

const Valideinsert = (req) => {
  const valida =
    objvalit.validator_vacio(req.body.nombreSalvAfec)

  const dataarray = [
    {
      datacom: 'nombreSalvAfec',
      valide: objvalit.validator_vacio(req.body.nombreSalvAfec)
    }
  ]

  const auxvalidetdata = dataarray.filter((item) => {
    return item.valide
  })
  console.log(auxvalidetdata)
  return { valida, auxvalidetdata }
}

module.exports = class ngclienAnalit {
  async insert_passalvafect (req, res) {
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

    const result = await objpassalvafect.insert_passalvafect(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }

  async actualise_passalvafect (req, res) {
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
    const result = await objpassalvafect.actualise_passalvafect(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }

  async list_passalvafect (req, res) {
    const result = await objpassalvafect.list_passalvafect(req, res)
    res.json(result)
  }

  async eliminar_passalvafect (req, res) {
    const result = await objpassalvafect.eliminar_passalvafect(req, res)
    res.json(result)
  }
}
