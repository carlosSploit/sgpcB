const Validator = require('../../config/complementos/validator')
const objvalit = new Validator()
const Bdtipotrabaj = require('../model/bd_tipocurso')
const objtipotrabaj = new Bdtipotrabaj()

const Validetipocurso = (req) => {
  const valida = objvalit.validator_vacio(req.body.name)

  const dataarray = [
    {
      datacom: 'name',
      valide: objvalit.validator_vacio(req.body.name)
    }
  ]

  const auxvalidetdata = dataarray.filter((item) => {
    return item.valide
  })
  console.log(auxvalidetdata)
  return { valida, auxvalidetdata }
}

module.exports = class ngtipocurso {
  async inser_tipocurso (req, res) {
    // validar datos insertados
    const validado = Validetipocurso(req)
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
    const result = await objtipotrabaj.inser_tipocurso(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }

  async actuali_tipocurso (req, res) {
    // validar datos insertados
    const validado = Validetipocurso(req)

    if (validado.valida) {
      res.send({
        status: 404,
        typo: 'error',
        messege: 'casillas mal ingresadas',
        data: validado.auxvalidetdata
      })
      return
    }
    // si todo esta correcto valida
    // let results = await conexibd.single_query(req, res,'CALL `insert_admin`(?,?,?,?,?,?);',[req.body.name, req.body.telf, req.body.correo, req.body.pass, req.body.tipoadm, req.body.photo])
    // return (Array.isArray(results))?results:[];
    const result = await objtipotrabaj.actualise_tipocurso(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }

  async list_tipocurso (req, res) {
    // let results = await conexibd.single_query(req, res,'CALL `list_admin`(?);',[req.params.name])
    // return (Array.isArray(results))?results:[];
    const result = await objtipotrabaj.list_tipocurso(req, res)
    res.json(result)
  }

  async delect_tipocurso (req, res) {
    // let results = await conexibd.single_query(req, res,'CALL `delect_admin`(?);',[req.params.id_admin],"Se elimino un usuario.")
    // return res.send(results);
    const result = await objtipotrabaj.delect_tipocurso(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }
}
