const Validator = require('../../config/complementos/validator')
const objvalit = new Validator()

const Bdcontesesion = require('../model/bd_contesesion')
const objcontesesion = new Bdcontesesion()

const Validecontesesion = (req) => {
  const valida =
    objvalit.validator_vacio(req.body.name) ||
    objvalit.validator_vacio(req.body.descr) ||
    objvalit.validator_url(req.body.urlcont)

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
      datacom: 'urlcont',
      valide: objvalit.validator_url(req.body.urlcont)
    }
  ]

  const auxvalidetdata = dataarray.filter((item) => {
    return item.valide
  })
  console.log(auxvalidetdata)
  return { valida, auxvalidetdata }
}

module.exports = class ngsesion {
  async inser_contesesion (req, res) {
    // validar datos insertados
    const validado = Validecontesesion(req)
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
    const result = await objcontesesion.inser_contesesion(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }

  async actualise_contesesion (req, res) {
    // validar datos insertados
    const validado = Validecontesesion(req)

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
    const result = await objcontesesion.actualise_contesesion(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }

  async list_contesesion (req, res) {
    // let results = await conexibd.single_query(req, res,'CALL `list_admin`(?);',[req.params.name])
    // return (Array.isArray(results))?results:[];
    const result = await objcontesesion.list_contesesion(req, res)
    res.json(result)
  }

  async delect_contesesion (req, res) {
    // let results = await conexibd.single_query(req, res,'CALL `delect_admin`(?);',[req.params.id_admin],"Se elimino un usuario.")
    // return res.send(results);
    const result = await objcontesesion.delect_contesesion(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }
}
