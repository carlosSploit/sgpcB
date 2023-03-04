const Validator = require('../../config/complementos/validator')
const objvalit = new Validator()
const Bdprofesor = require('../model/bd_profesor')
const objprofesor = new Bdprofesor()
const Ngpointclass = require('./pointclass.negocio')
const objpointclass = new Ngpointclass()

const Valideinsert = (req) => {
  const valida =
    objvalit.validator_vacio(req.body.name) ||
    objvalit.validator_celular(req.body.telf) ||
    objvalit.validator_mail(req.body.correo) ||
    objvalit.validator_vacio(req.body.pass) ||
    objvalit.validator_vacio(req.body.estudios) ||
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
      datacom: 'estudios',
      valide: objvalit.validator_vacio(req.body.estudios)
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
  async inser_profe (req, res) {
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
    // let results = await conexibd.single_query(req, res,'CALL `insert_admin`(?,?,?,?,?,?);',[req.body.name, req.body.telf, req.body.correo, req.body.pass, req.body.tipoadm, req.body.photo])
    // return (Array.isArray(results))?results:[];
    const listresult = await objprofesor.inser_profe(req, res)
    const resutld = listresult[0]
    const resultdata = await objpointclass.inser_pointclass_default_methond(
      req,
      res,
      resutld.id_prof
    )
    console.log(resultdata)
    if (resultdata.status === 404) {
      res.send({
        status: 404,
        typo: 'error',
        messege:
          'Se a insertado el profesor con exito, pero los puntos predeterminado no se ingresaron.'
      })
      return
    }
    res.send({
      status: 200,
      typo: 'succes',
      messege: 'Se a insertado el profesor con exito.'
    })
  }

  async actuali_profe (req, res) {
    // console.log(req.params)
    // validar si el usuario existe si se ingresa nuevos usuarios y contraseñas
    // console.log(req.body)
    // console.log(datainfoProfesor)
    // la suma del '' ayuda castiar de any a string
    const listinfoProfesor = await objprofesor.read_profe(req, res)
    const datainfoProfesor = listinfoProfesor[0]
    if (!(((datainfoProfesor.correo + '') === (req.body.correo + '')) && ((datainfoProfesor.pass + '') === (req.body.pass + '')))) {
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
    }
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
    // let results = await conexibd.single_query(req, res,'CALL `insert_admin`(?,?,?,?,?,?);',[req.body.name, req.body.telf, req.body.correo, req.body.pass, req.body.tipoadm, req.body.photo])
    // return (Array.isArray(results))?results:[];
    const result = await objprofesor.actuali_profe(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }

  async list_profe (req, res) {
    // let results = await conexibd.single_query(req, res,'CALL `list_admin`(?);',[req.params.name])
    // return (Array.isArray(results))?results:[];
    const result = await objprofesor.list_profe(req, res)
    res.json(result)
  }

  async delect_profe (req, res) {
    // let results = await conexibd.single_query(req, res,'CALL `delect_admin`(?);',[req.params.id_admin],"Se elimino un usuario.")
    // return res.send(results);
    const result = await objprofesor.delect_profe(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result,
      data: []
    })
  }

  async read_profe (req, res) {
    // let results = await conexibd.single_query(req, res,'CALL `read_admin`(?);',[req.params.id_admin])
    // return (Array.isArray(results))?results:[];
    const result = await objprofesor.read_profe(req, res)
    res.json(result[0])
  }
}
