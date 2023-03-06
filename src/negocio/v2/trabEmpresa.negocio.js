const Validator = require('../../../config/complementos/validator')
const objvalit = new Validator()
const BdtrabEmpresa = require('../../model/v2/trabEmpresa.bd')
const objtrabEmpresa = new BdtrabEmpresa()

const Valideinsert = (req) => {
  const valida =
    objvalit.validator_vacio(req.body.nombre) ||
    objvalit.validator_vacio(req.body.cargo) ||
    objvalit.validator_vacio(req.body.descripc) ||
    objvalit.validator_celular(req.body.telefono) ||
    objvalit.validator_mail(req.body.correo) ||
    objvalit.validator_vacio(req.body.codTrabajo)

  const dataarray = [
    {
      datacom: 'nombre',
      valide: objvalit.validator_vacio(req.body.nombre)
    },
    {
      datacom: 'cargo',
      valide: objvalit.validator_vacio(req.body.cargo)
    },
    {
      datacom: 'descripc',
      valide: objvalit.validator_vacio(req.body.descripc)
    },
    {
      datacom: 'telefono',
      valide: objvalit.validator_celular(req.body.telefono)
    },
    {
      datacom: 'correo',
      valide: objvalit.validator_mail(req.body.correo)
    },
    {
      datacom: 'codTrabajo',
      valide: objvalit.validator_vacio(req.body.codTrabajo)
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

module.exports = class ngtrabajempres {
  async inser_trabajempresa (req, res) {
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

    const result = await objtrabEmpresa.inser_trabajempresa(req, res)
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
    const result = await objtrabEmpresa.actualise_areasempresa(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }

  async list_trabEmpresa (req, res) {
    const result = await objtrabEmpresa.list_trabEmpresa(req, res)
    res.json(result)
  }

  async eliminar_areasempresa (req, res) {
    const result = await objtrabEmpresa.eliminar_areasempresa(req, res)
    res.json(result)
  }
}
