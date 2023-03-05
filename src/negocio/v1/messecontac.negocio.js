const Validator = require('../../config/complementos/validator')
const objvalit = new Validator()
const enviarmess = require('../../config/smtp/nodemulter/nodemulter')
// const Bdadmin = require('../model/bd_admin')
// const objadmin = new Bdadmin()

const Valideinsert = (req) => {
  const valida =
    objvalit.validator_vacio(req.body.nombre) ||
    objvalit.validator_mail(req.body.correo) ||
    objvalit.validator_vacio(req.body.mensaje)

  const dataarray = [
    {
      datacom: 'nombre',
      valide: objvalit.validator_vacio(req.body.nombre)
    },
    {
      datacom: 'correo',
      valide: objvalit.validator_mail(req.body.correo)
    },
    {
      datacom: 'mensaje',
      valide: objvalit.validator_vacio(req.body.mensaje)
    }
  ]

  const auxvalidetdata = dataarray.filter((item) => {
    return item.valide
  })
  console.log(auxvalidetdata)
  return { valida, auxvalidetdata }
}

module.exports = class ngadmin {
  async enviarcorreocontact (req, res) {
    // validar datos insertados
    const validado = Valideinsert(req)

    if (validado.valida) {
      res.send({
        status: 404,
        typo: 'error',
        messege: 'Casillas mal ingresadas',
        data: validado.auxvalidetdata
      })
      return
    }
    // cuando el usuario quiere enviar un correo a la empresa
    const messege = `El cliente ${req.body.nombre} con el correo ${req.body.correo}, a enviado el siguiente mensaje:${req.body.mensaje}.`
    const title = 'Mensaje de Cliente'
    enviarmess('cavarithprueba2004@gmail.com', title, messege)
    res.send({
      status: 200,
      typo: 'succes',
      messege: 'El correo fue enviado con exito.'
    })
  }
}
