const Validator = require('../../../config/complementos/validator')
const objvalit = new Validator()
const Bdobjempresa = require('../../model/v2/objempresa.bd')
const objobjempresa = new Bdobjempresa()

const Valideinsert = (req) => {
  const valida =
    objvalit.validator_vacio(req.body.nombreObje)

  const dataarray = [
    {
      datacom: 'nombreObje',
      valide: objvalit.validator_vacio(req.body.nombreObje)
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
  async inser_objempresa (req, res) {
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

    const result = await objobjempresa.inser_objempresa(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }

  async actualise_objempresa (req, res) {
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
    const result = await objobjempresa.actualise_objempresa(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }

  async list_objempresa (req, res) {
    const result = await objobjempresa.list_objempresa(req, res)
    res.json(result)
  }

  async eliminar_objempresa (req, res) {
    const result = await objobjempresa.eliminar_objempresa(req, res)
    res.json(result)
  }
}
