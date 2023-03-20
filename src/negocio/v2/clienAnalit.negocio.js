const Validator = require('../../../config/complementos/validator')
const objvalit = new Validator()
const BdclienAnalit = require('../../model/v2/clienteAnalit.bd')
const objclienAnalit = new BdclienAnalit()
const Bdusuario = require('../../model/v2/usuario.bd')
const objusuario = new Bdusuario()

const Valideinsert = (req) => {
  const valida =
    objvalit.validator_vacio(req.body.nombre) ||
    objvalit.validator_vacio(req.body.apellidos) ||
    objvalit.validator_celular(req.body.telf) ||
    objvalit.validator_mail(req.body.correo) ||
    objvalit.validator_vacio(req.body.pass) ||
    objvalit.validator_url(req.body.photo)
  const dataarray = [
    {
      datacom: 'nombre',
      valide: objvalit.validator_vacio(req.body.nombre)
    },
    {
      datacom: 'apellidos',
      valide: objvalit.validator_vacio(req.body.apellidos)
    },
    {
      datacom: 'telf',
      valide: objvalit.validator_celular(req.body.telf)
    },
    {
      datacom: 'correo',
      valide: objvalit.validator_mail(req.body.correo)
    },
    {
      datacom: 'pass',
      valide: objvalit.validator_vacio(req.body.pass)
    },
    {
      datacom: 'photo',
      valide: objvalit.validator_url(req.body.photo)
    }
  ]

  const auxvalidetdata = dataarray.filter((item) => {
    return item.valide
  })
  console.log(auxvalidetdata)
  return { valida, auxvalidetdata }
}

const Valideupdate = (req) => {
  const valida =
    objvalit.validator_vacio(req.body.nombre) ||
    objvalit.validator_vacio(req.body.apellidos) ||
    objvalit.validator_celular(req.body.telf) ||
    objvalit.validator_url(req.body.photo)
  const dataarray = [
    {
      datacom: 'nombre',
      valide: objvalit.validator_vacio(req.body.nombre)
    },
    {
      datacom: 'apellidos',
      valide: objvalit.validator_vacio(req.body.apellidos)
    },
    {
      datacom: 'telf',
      valide: objvalit.validator_celular(req.body.telf)
    },
    {
      datacom: 'photo',
      valide: objvalit.validator_url(req.body.photo)
    }
  ]

  const auxvalidetdata = dataarray.filter((item) => {
    return item.valide
  })
  console.log(auxvalidetdata)
  return { valida, auxvalidetdata }
}

const ValideupdateInfoSecion = (req) => {
  const valida =
    objvalit.validator_mail(req.body.correo) ||
    objvalit.validator_vacio(req.body.pass)
  const dataarray = [
    {
      datacom: 'correo',
      valide: objvalit.validator_vacio(req.body.correo)
    },
    {
      datacom: 'pass',
      valide: objvalit.validator_vacio(req.body.pass)
    }
  ]

  const auxvalidetdata = dataarray.filter((item) => {
    return item.valide
  })
  console.log(auxvalidetdata)
  return { valida, auxvalidetdata }
}

const ValideCorreoandPass = async (req, res) => {
  // se verifica si el usuario o la contraseña ya estan registrados o no
  const valitusser = await objusuario.compruebe_correo(req, res, req.body.correo)
  if (valitusser.length === 1 && valitusser[0].userEnlance > 0) {
    // si ya existe un usuario con el mismo correo y contraseña
    return {
      status: 404,
      typo: 'error',
      messege: `Este correo electronico presenta ${valitusser[0].userEnlance} cuentas enlazadas`
    }
  }
  return {
    status: 200
  }
}

const ValideCompruebeCambioDatCorreo = async (req, res) => {
  // se verifica si el usuario o la contraseña ya estan registrados o no
  const valitusser = await objclienAnalit.read_clienAnalit(req, res)
  if (valitusser.length === 0) return true
  if (valitusser[0].correo === req.body.correo) {
    return false
  }
  return true
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
  async inser_clienAnalit (req, res) {
    // validar datos insertados
    const validado = Valideinsert(req)

    if (validado.valida) {
      res.send({
        status: 404,
        typo: 'error',
        messege: 'casillas mal ingresadas',
        data: validado.auxvalidetdata
      })
      // eslint-disable-next-line no-useless-return
      return
    }

    // validar si el usuario existe si se ingresa nuevos usuarios y contraseñas
    const valideCorPass = await ValideCorreoandPass(req, res)
    if (valideCorPass.status === 404) return res.send(valideCorPass)

    // generar el username
    const correo = req.body.correo
    const listdatauser = correo.split('@')
    req.body.username = '@' + listdatauser[0]

    // si todo esta correcto retorna los datos
    // let results = await conexibd.single_query(req, res,'CALL `insert_clienAnalit`(?,?,?,?,?,?);',[req.body.name, req.body.telf, req.body.correo, req.body.pass, req.body.tipoadm, req.body.photo])
    // return (Array.isArray(results))?results:[];

    const result = await objclienAnalit.inser_clienAnalit(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }

  async actuali_clienAnalit (req, res) {
    // validar datos insertados
    const validado = Valideupdate(req)

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
    const result = await objclienAnalit.actualise_clienAnalit(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }

  async actuali_clienAnalitInfoUser (req, res) {
    // validar datos insertados
    const validado = ValideupdateInfoSecion(req)

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

    // validar si el usuario existe si se ingresa nuevos usuarios y contraseñas
    const valideCorPass = await ValideCorreoandPass(req, res)
    const valideComprCor = await ValideCompruebeCambioDatCorreo(req, res)
    if (valideCorPass.status === 404 && valideComprCor) return res.send(valideCorPass)

    // generar el username
    const correo = req.body.correo
    const listdatauser = correo.split('@')
    req.body.username = '@' + listdatauser[0]

    // si todo esta correcto, inserta los datos
    const result = await objclienAnalit.actuali_clienAnalitInfoUser(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }

  async list_clienAnalit (req, res) {
    const result = await objclienAnalit.list_clienAnalit(req, res)
    res.json(result)
  }

  // async delect_clienAnalit (req, res) {
  //   const result = await objclienAnalit.delect_clienAnalit(req, res)
  //   res.send({
  //     status: 200,
  //     typo: 'succes',
  //     messege: result
  //   })
  // }

  async read_clienAnalit (req, res) {
    const result = await objclienAnalit.read_clienAnalit(req, res)
    res.json(result[0])
  }
}
