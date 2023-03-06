const Validator = require('../../../config/complementos/validator')
const objvalit = new Validator()
const Bdareasempresa = require('../../model/v2/areasempresa.bd')
const objareasempresa = new Bdareasempresa()

const Valideinsert = (req) => {
  const valida =
    objvalit.validator_vacio(req.body.nombrearea) ||
    objvalit.validator_vacio(req.body.descriparea)

  const dataarray = [
    {
      datacom: 'nombrearea',
      valide: objvalit.validator_vacio(req.body.nombrearea)
    },
    {
      datacom: 'descriparea',
      valide: objvalit.validator_vacio(req.body.descriparea)
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

module.exports = class ngclienAnalit {
  async inser_areasempresa (req, res) {
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

    const result = await objareasempresa.inser_areasempresa(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }

  async actualise_areasempresa (req, res) {
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
    const result = await objareasempresa.actualise_areasempresa(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }

  async list_areasempresa (req, res) {
    const result = await objareasempresa.list_areasempresa(req, res)
    res.json(result)
  }

  async eliminar_areasempresa (req, res) {
    const result = await objareasempresa.eliminar_areasempresa(req, res)
    res.json(result)
  }
}
