const Validator = require('../../../config/complementos/validator')
const objvalit = new Validator()
const Bdsalvafectact = require('../../model/v2/salvafectact.bd')
const objsalvafectact = new Bdsalvafectact()

const Valideinsert = (req) => {
  const valida =
    objvalit.validator_vacio(req.body.extrategia)

  const dataarray = [
    {
      datacom: 'extrategia',
      valide: objvalit.validator_vacio(req.body.extrategia)
    }
  ]

  const auxvalidetdata = dataarray.filter((item) => {
    return item.valide
  })
  console.log(auxvalidetdata)
  return { valida, auxvalidetdata }
}

// const ValideCorreoandPassUpdate = async (req, res) => {
//   // se verifica que que no hayan cambios
//   const listinfoadmin = await objclienAnalit.read_admin(req, res)
//   const datainfoadmin = listinfoadmin[0]
//   console.log(datainfoadmin)
//   if (!(((datainfoadmin.correo + '') === (req.body.correo + '')) && ((datainfoadmin.pass + '') === (req.body.pass + '')))) {
//     const valideCorAndPass = await ValideCorreoandPass(req, res)
//     // si ya existe un usuario con el mismo correo y contraseña
//     if (valideCorAndPass.status === 404) return valideCorAndPass
//   }
//   // si no existe el usuario con el correo y contraseña
//   return {
//     status: 200
//   }
// }

module.exports = class ngsalvAfectAct {
  async insert_salvAfectAct (req, res) {
    // validar datos insertados
    const validado = Valideinsert(req)

    if (validado.valida) {
      res.send({
        status: 404,
        typo: 'error',
        messege: 'Casillas mal ingresadas.',
        data: validado.auxvalidetdata
      })
      // eslint-disable-next-line no-useless-return
      return
    }

    if (parseInt(req.body.id_salvaguarda) === 0) {
      res.send({
        status: 404,
        typo: 'error',
        messege: 'Erro, porfavor enlazar una salvaguarda.',
        data: ''
      })
    }

    const result = await objsalvafectact.insert_salvAfectAct(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }

  async actualizo_salvAfectAct (req, res) {
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
    const result = await objsalvafectact.actualizo_salvAfectAct(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }

  async list_salvAfectAct (req, res) {
    const result = await objsalvafectact.list_salvAfectAct(req, res)
    res.json(result)
  }

  async delete_salvAfectAct (req, res) {
    const result = await objsalvafectact.eliminar_salvAfectAct(req, res)
    res.json(result)
  }
}
