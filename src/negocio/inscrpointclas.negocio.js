const Validator = require('../../config/complementos/validator')
const objvalit = new Validator()
const Bdpointclass = require('../model/bd_puntosclass')
const objpunt = new Bdpointclass()
const Bdinscrpointclas = require('../model/bd_inscrpointclas')
const objadmin = new Bdinscrpointclas()

const Valideinsert = (req) => {
  const valida =
    objvalit.validator_integer(req.body.id_inscrip) ||
    objvalit.validator_integer(req.body.id_inscrip)
      ? parseInt(req.body.id_inscrip.toString())
      : false ||
        objvalit.validator_integer(req.body.id_tipopunt) ||
        objvalit.validator_integer(req.body.id_inscrip)
        ? parseInt(req.body.id_tipopunt.toString())
        : false || objvalit.validator_integer(req.body.id_sesion)
  // objvalit.validator_url(req.body.photo)

  const dataarray = [
    {
      datacom: 'id_inscrip',
      valide: objvalit.validator_integer(req.body.id_inscrip)
    },
    {
      datacom: 'id_inscrip',
      valide: objvalit.validator_integer(req.body.id_inscrip)
        ? parseInt(req.body.id_inscrip.toString()) <= 0
        : false
    },
    {
      datacom: 'id_tipopunt',
      valide: objvalit.validator_integer(req.body.id_tipopunt)
    },
    {
      datacom: 'id_tipopunt',
      valide: objvalit.validator_integer(req.body.id_inscrip)
        ? parseInt(req.body.id_tipopunt.toString()) <= 0
        : false
    },
    {
      datacom: 'id_sesion',
      valide: objvalit.validator_integer(req.body.id_sesion)
    }
    // ,{
    //     datacom: "photo",
    //     valide: objvalit.validator_url(req.body.photo)
    // }
  ]

  const auxvalidetdata = dataarray.filter((item) => {
    return item.valide
  })
  console.log(auxvalidetdata)
  return { valida, auxvalidetdata }
}

module.exports = class nginscrpointclas {
  async add_inscripuntclas (req, res) {
    // validar datos insertados
    const validado = Valideinsert(req)

    if (validado.valida) {
      return {
        status: 404,
        typo: 'error',
        messege: 'casillas mal ingresadas',
        data: validado.auxvalidetdata
      }
    }
    // si todo esta correcto retorna los datos
    const validcuantifi = await objpunt.valid_puntos_class(
      req,
      res,
      req.body.id_tipopunt
    )
    // console.log(validcuantifi);
    // si no rescata nada de la id, es porque no existe o porque fue eliminado
    if (parseInt(validcuantifi) === -1) {
      return {
        status: 404,
        typo: 'error',
        messege: 'Tipo de punto no existente.',
        data: validado.auxvalidetdata
      }
    }
    // si es igual a 0 es porque no es acumulable, y si lo es pasa a la siguiente opccion
    // primero se debe validar si ya cuenta con puntos
    const resultlistpoint = await objadmin.valider_inscpointclas(req, res)
    console.log(resultlistpoint)
    // si ya se le dio puntaje a un inscrito en una secion se comprobara si es acumulable o no
    if (resultlistpoint.length > 0) {
      if (parseInt(validcuantifi) === 0) {
        return {
          status: 404,
          typo: 'error',
          messege: 'El punto no es acumulable.',
          data: validado.auxvalidetdata
        }
      }
    }
    // console.log("Esta insertando");
    const result = await objadmin.inser_inscripuntclas(req, res)
    return {
      status: 200,
      typo: 'succes',
      messege: result
    }
  }

  async inser_inscrpointclas (req, res) {
    const result = await this.add_inscripuntclas(req, res)
    res.send(result)
  }

  async valider_inscpointclas (req, res) {
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
    const result = await objadmin.valider_inscpointclas(req, res)
    res.json(result)
  }

  async list_inscpointclas (req, res) {
    // let results = await conexibd.single_query(req, res,'CALL `list_admin`(?);',[req.params.name])
    // return (Array.isArray(results))?results:[];
    const result = await objadmin.list_inscripuntclas(req, res)
    res.json(result)
  }

  async delect_inscripuntclas (req, res) {
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
    // let results = await conexibd.single_query(req, res,'CALL `delect_admin`(?);',[req.params.id_admin],"Se elimino un usuario.")
    // return res.send(results);
    const result = await objadmin.delect_inscripuntclas(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }
}
