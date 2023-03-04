const Validator = require('../../config/complementos/validator')
const objvalit = new Validator()
const Bdadmin = require('../model/bd_admin')
const objadmin = new Bdadmin()

const Valideinsert = (req) => {
  const valida =
    objvalit.validator_vacio(req.body.name) ||
    objvalit.validator_celular(req.body.telf) ||
    objvalit.validator_mail(req.body.correo) ||
    objvalit.validator_vacio(req.body.pass) ||
    objvalit.validator_vacio(req.body.tipoadm) ||
    objvalit.validator_url(req.body.photo)
  const dataarray = [
    {
      datacom: 'name',
      valide: objvalit.validator_vacio(req.body.name)
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
      datacom: 'tipoadm',
      valide: objvalit.validator_vacio(req.body.tipoadm)
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

const ValideCorreoandPass = async (req, res) => {
  // se verifica si el usuario o la contraseña ya estan registrados o no
  const valitusser = await objvalit.validator_user(
    req,
    res,
    req.body.correo,
    req.body.pass
  )
  if (valitusser) {
    // si ya existe un usuario con el mismo correo y contraseña
    return {
      status: 404,
      typo: 'error',
      messege: 'El correo y la contraseña ya pertenecen a un usuario'
    }
  }
  return {
    status: 200
  }
}

const ValideCorreoandPassUpdate = async (req, res) => {
  // se verifica que que no hayan cambios
  const listinfoadmin = await objadmin.read_admin(req, res)
  const datainfoadmin = listinfoadmin[0]
  console.log(datainfoadmin)
  if (!(((datainfoadmin.correo + '') === (req.body.correo + '')) && ((datainfoadmin.pass + '') === (req.body.pass + '')))) {
    const valideCorAndPass = await ValideCorreoandPass(req, res)
    // si ya existe un usuario con el mismo correo y contraseña
    if (valideCorAndPass.status === 404) return valideCorAndPass
  }
  // si no existe el usuario con el correo y contraseña
  return {
    status: 200
  }
}

module.exports = class ngadmin {
  async inser_admin (req, res) {
    // validar si el usuario existe si se ingresa nuevos usuarios y contraseñas
    const valideCorPass = await ValideCorreoandPass(req, res)
    if (valideCorPass.status === 404) return res.send(valideCorPass)
    // validar datos insertados
    const validado = Valideinsert(req)

    if (validado.valida) {
      res.send({
        status: 404,
        typo: 'error',
        messege: 'casillas mal ingresadas',
        data: validado.auxvalidetdata
      })
      return
    }
    // si todo esta correcto retorna los datos
    // let results = await conexibd.single_query(req, res,'CALL `insert_admin`(?,?,?,?,?,?);',[req.body.name, req.body.telf, req.body.correo, req.body.pass, req.body.tipoadm, req.body.photo])
    // return (Array.isArray(results))?results:[];
    const result = await objadmin.inser_admin(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }

  async actuali_admin (req, res) {
    // validar si el usuario existe si se ingresa nuevos usuarios y contraseñas
    const valideCorPass = await ValideCorreoandPassUpdate(req, res)
    if (valideCorPass.status === 404) return res.send(valideCorPass)
    // validar datos insertados
    const validado = Valideinsert(req)

    if (validado.valida) {
      res.send({
        status: 404,
        typo: 'error',
        messege: 'casillas mal ingresadas',
        data: validado.auxvalidetdata
      })
      return
    }
    // si todo esta correcto, inserta los datos
    const result = await objadmin.actualise_admin(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }

  async list_admin (req, res) {
    const result = await objadmin.list_admin(req, res)
    res.json(result)
  }

  async delect_admin (req, res) {
    const result = await objadmin.delect_admin(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }

  async read_admin (req, res) {
    const result = await objadmin.read_admin(req, res)
    res.json(result[0])
  }
}
