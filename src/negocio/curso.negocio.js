const Validator = require('../../config/complementos/validator')
const objvalit = new Validator()
const Bdcurso = require('../model/bd_curso')
const objcurso = new Bdcurso()

const Valideinsert = (req) => {
  const valida =
    objvalit.validator_vacio(req.body.name) ||
    objvalit.validator_vacio(req.body.descr) ||
    objvalit.validator_vacio(req.body.alcan) ||
    objvalit.validator_url(req.body.photpo)
  const dataarray = [
    {
      datacom: 'name',
      valide: objvalit.validator_vacio(req.body.name)
    },
    {
      datacom: 'descr',
      valide: objvalit.validator_vacio(req.body.descr)
    },
    {
      datacom: 'alcan',
      valide: objvalit.validator_vacio(req.body.alcan)
    },
    {
      datacom: 'photpo',
      valide: objvalit.validator_url(req.body.photpo)
    }
  ]

  const auxvalidetdata = dataarray.filter((item) => {
    return item.valide
  })
  console.log(auxvalidetdata)
  return { valida, auxvalidetdata }
}

module.exports = class ngcurso {
  async inser_curso (req, res) {
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
    const result = await objcurso.inser_curso(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }

  async actuali_curso (req, res) {
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
    const result = await objcurso.actuali_curso(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }

  async list_curso (req, res) {
    // let results = await conexibd.single_query(req, res,'CALL `list_admin`(?);',[req.params.name])
    // return (Array.isArray(results))?results:[];
    const result = await objcurso.list_curso(req, res)
    res.json(result)
  }

  async delect_curso (req, res) {
    // let results = await conexibd.single_query(req, res,'CALL `delect_admin`(?);',[req.params.id_admin],"Se elimino un usuario.")
    // return res.send(results);
    const result = await objcurso.delect_curso(req, res)
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
    const result = await objcurso.read_profe(req, res)
    res.json(result[0])
  }
}
