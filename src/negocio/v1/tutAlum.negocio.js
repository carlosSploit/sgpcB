// const enviarmess = require('../../config/smtp/nodemulter/nodemulter')
const Validator = require('../../config/complementos/validator')
const objvalit = new Validator()
const BdtutAlum = require('../model/bd_tutAlum')
const objalumno = new BdtutAlum()

const Valideinsert = (req) => {
  const valida =
    objvalit.validator_vacio(req.body.name) ||
    objvalit.validator_celular(req.body.telf) ||
    objvalit.validator_mail(req.body.correo) ||
    objvalit.validator_vacio(req.body.pass) ||
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

module.exports = class ngprofesor {
  async inser_alumno (req, res) {
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

    // validar si el usuario existe
    const valitusser = await objvalit.validator_user(
      req,
      res,
      req.body.correo,
      req.body.pass
    )
    if (valitusser) {
      res.send({
        status: 404,
        typo: 'error',
        messege: 'El correo y la contraseña ya pertenecen a un usuario'
      })
      return
    }

    // let results = await conexibd.single_query(req, res,'CALL `insert_admin`(?,?,?,?,?,?);',[req.body.name, req.body.telf, req.body.correo, req.body.pass, req.body.tipoadm, req.body.photo])
    // return (Array.isArray(results))?results:[];
    // le envian un correo de bienvenida al usuario
    // const messege = `Gracias por confiar en nosotros ${req.body.name}, ojala que te guste nuestro servicio de talleres, inscribete a nuestros talleres variados a tu gusto.`
    // const title = '! Bienvenido a Canvaritech ¡'
    // enviarmess(req.body.correo,title,messege);

    const result = await objalumno.inser_tutAlum(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }

  async list_tutalum (req, res) {
    // let results = await conexibd.single_query(req, res,'CALL `list_admin`(?);',[req.params.name])
    // return (Array.isArray(results))?results:[];
    const result = await objalumno.list_tutalum(req, res)
    res.json(result)
  }
}
