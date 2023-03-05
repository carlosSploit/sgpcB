const Bdconttarea = require('../model/bd_contactiv')
const objcontactiva = new Bdconttarea()
const Validator = require('../../config/complementos/validator')
const objvalit = new Validator()
const Bdtareainscrip = require('../model/bd_tareainscrip')
const objtareainscrip = new Bdtareainscrip()

const Validecontactiva = (req) => {
  const valida = objvalit.validator_url(req.body.urlcont)

  const dataarray = [
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
  async insert_tareainscr (req, res) {
    // validar datos insertados
    const validado = Validecontactiva(req)
    if (validado.valida) {
      res.send({
        status: 404,
        typo: 'error',
        messege: 'casillas mal ingresadas',
        data: validado.auxvalidetdata
      })
      return
    }
    // si el inscrito en el ciclo de curso ya ingreso su tarea
    const listresulins = await objtareainscrip.list_tareainscr(
      req,
      res,
      req.body.id_conttar
    )
    const inscripresult = listresulins.filter((item) => {
      return parseInt(item.id_inscrip) === parseInt(req.body.id_inscr)
    })
    if (inscripresult.length > 0) {
      res.send({
        status: 404,
        typo: 'error',
        messege:
          'Ya presenta una resolucion para esta tarea, si desea editala.',
        data: []
      })
      return
    }

    const result = await objtareainscrip.insert_tareainscr(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }

  async actualise_tareainsc (req, res) {
    // validar datos insertados
    const validado = Validecontactiva(req)

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
    const result = await objtareainscrip.update_tareainsc(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }

  async actualise_tareainsc_to_point (req, res) {
    // si todo esta correcto valida
    // let results = await conexibd.single_query(req, res,'CALL `insert_admin`(?,?,?,?,?,?);',[req.body.name, req.body.telf, req.body.correo, req.body.pass, req.body.tipoadm, req.body.photo])
    // return (Array.isArray(results))?results:[];
    const dataconsult = await objcontactiva.read_contactiva(
      req,
      res,
      req.body.id_conttare
    )
    // console.log(req.body.id_conttare);
    // console.log(dataconsult);
    // console.log(dataconsult);
    console.log(
      `${parseInt(req.body.point)} > ${parseInt(dataconsult[0].point_max)}`
    )
    if (parseInt(req.body.point) > parseInt(dataconsult[0].point_max)) {
      res.send({
        status: 404,
        typo: 'error',
        messege: 'Los puntos sobrepasan los limites de designar.',
        data: []
      })
      return
    }

    const result = await objtareainscrip.update_tareainsc_to_puntos(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }

  async list_tareainscr (req, res) {
    // let results = await conexibd.single_query(req, res,'CALL `list_admin`(?);',[req.params.name])
    // return (Array.isArray(results))?results:[];
    const result = await objtareainscrip.list_tareainscr(req, res)
    res.json(result)
  }

  async list_tareainscr_ranking (req, res) {
    // let results = await conexibd.single_query(req, res,'CALL `list_admin`(?);',[req.params.name])
    // return (Array.isArray(results))?results:[];
    const result = await objtareainscrip.list_tareainscr_ranking(req, res)
    res.json(result)
  }

  async delect_tareainscr (req, res) {
    // let results = await conexibd.single_query(req, res,'CALL `delect_admin`(?);',[req.params.id_admin],"Se elimino un usuario.")
    // return res.send(results);
    const result = await objtareainscrip.delect_tareainscr(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }
}
