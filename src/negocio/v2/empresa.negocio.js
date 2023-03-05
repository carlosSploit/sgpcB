const Validator = require('../../../config/complementos/validator')
const objvalit = new Validator()
const Bdempresa = require('../../model/v2/empresa.bd')
const objempresa = new Bdempresa()

const Valideinsert = (req) => {
  const valida =
    objvalit.validator_vacio(req.body.nombreempresa) ||
    objvalit.validator_vacio(req.body.ruc) ||
    objvalit.validator_vacio(req.body.descripc) ||
    objvalit.validator_vacio(req.body.telefono)

  const dataarray = [
    {
      datacom: 'nombreempresa',
      valide: objvalit.validator_vacio(req.body.nombreempresa)
    },
    {
      datacom: 'ruc',
      valide: objvalit.validator_vacio(req.body.ruc)
    },
    {
      datacom: 'descripc',
      valide: objvalit.validator_vacio(req.body.descripc)
    },
    {
      datacom: 'telefono',
      valide: objvalit.validator_vacio(req.body.telefono)
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
  async inser_empresa (req, res) {
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

    const result = await objempresa.inser_empresa(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }

  // async actuali_clienAnalit (req, res) {
  //   // validar datos insertados
  //   const validado = Valideupdate(req)

  //   if (validado.valida) {
  //     res.send({
  //       status: 404,
  //       typo: 'error',
  //       messege: 'Casillas mal ingresadas',
  //       data: validado.auxvalidetdata
  //     })
  //     // eslint-disable-next-line no-useless-return
  //     return
  //   }

  //   // si todo esta correcto, inserta los datos
  //   const result = await objclienAnalit.actualise_clienAnalit(req, res)
  //   res.send({
  //     status: 200,
  //     typo: 'succes',
  //     messege: result
  //   })
  // }

  // async actuali_clienAnalitInfoUser (req, res) {
  //   // validar datos insertados
  //   const validado = ValideupdateInfoSecion(req)

  //   if (validado.valida) {
  //     res.send({
  //       status: 404,
  //       typo: 'error',
  //       messege: 'Casillas mal ingresadas',
  //       data: validado.auxvalidetdata
  //     })
  //     // eslint-disable-next-line no-useless-return
  //     return
  //   }

  //   // validar si el usuario existe si se ingresa nuevos usuarios y contraseñas
  //   const valideCorPass = await ValideCorreoandPass(req, res)
  //   if (valideCorPass.status === 404) return res.send(valideCorPass)

  //   // generar el username
  //   const correo = req.body.correo
  //   const listdatauser = correo.split('@')
  //   req.body.username = '@' + listdatauser[0]

  //   // si todo esta correcto, inserta los datos
  //   const result = await objclienAnalit.actuali_clienAnalitInfoUser(req, res)
  //   res.send({
  //     status: 200,
  //     typo: 'succes',
  //     messege: result
  //   })
  
  // }

  async list_empresa (req, res) {
    const result = await objempresa.list_empresa(req, res)
    res.json(result)
  }
}
