const Bdinscrip = require('../model/bd_inscripccion')
const objinscrip = new Bdinscrip()
const Validator = require('../../config/complementos/validator')
const objvalit = new Validator()
const Bdasistencia = require('../model/bd_asistencia')
const objasistencia = new Bdasistencia()
const NgPointClass = require('./pointclass.negocio')
const objPointClass = new NgPointClass()

const Valideinsert = (req) => {
  const valida = objvalit.validator_integer(req.body.stade)

  const dataarray = [
    {
      datacom: 'stade',
      valide: objvalit.validator_integer(req.body.stade)
    }
  ]

  const auxvalidetdata = dataarray.filter((item) => {
    return item.valide
  })
  console.log(auxvalidetdata)
  return { valida, auxvalidetdata }
}

const ValideinsertData = (req) => {
  const valida = ((!objvalit.validator_integer(req.body.id_sesion)) ? (parseInt(req.body.id_sesion) === 0) : true) ||
  ((!objvalit.validator_integer(req.body.id_ciclocur)) ? (parseInt(req.body.id_ciclocur) === 0) : true)

  const dataarray = [
    {
      datacom: 'id_sesion',
      valide: objvalit.validator_integer(req.body.id_sesion)
    },
    {
      datacom: 'id_ciclocur',
      valide: objvalit.validator_integer(req.body.id_sesion)
    }
  ]

  const auxvalidetdata = dataarray.filter((item) => {
    return item.valide
  })
  console.log(auxvalidetdata)
  return { valida, auxvalidetdata }
}

module.exports = class ngcurso {
  async inser_apertureasistencia (req, res) {
    // valida las casillas
    const validado = ValideinsertData(req)

    if (validado.valida) {
      res.send({
        status: 404,
        typo: 'error',
        messege: 'Se an insertado mal las casillas de id de sesion y la id de ciclo de curso.',
        data: validado.auxvalidetdata
      })
      return
    }
    // validar si hay alumnos para realizar una apertura de asistencia
    const usserinscrip = await objinscrip.list_inscrip_the_alumno(
      req,
      res,
      req.body.id_ciclocur
    )
    if (usserinscrip.length === 0) {
      res.send({
        status: 404,
        typo: 'error',
        messege:
          'No hay alumnos en el curso, porfavor espere las inscripcciones de los alumnos.',
        data: []
      })
      return
    }
    // validar si ya hay una apertura en este dia
    const listaperasis = await objasistencia.list_apertureasistencia(
      req,
      res,
      req.body.id_ciclocur
    )
    const filter = listaperasis.filter((item) => {
      const tiempoTranscurrido = Date.now()
      const dateactual = new Date(tiempoTranscurrido)
      const datedateactualact = new Date(
        dateactual.getFullYear(),
        dateactual.getMonth(),
        dateactual.getDate()
      )
      const dateapertu = new Date(item.fecha_asist)
      // console.log(`${dateapertu.getTime()} == ${datedateactualact.getTime()}`);
      return (
        dateapertu.getTime() === datedateactualact.getTime() &&
        parseInt(item.id_sesion) === parseInt(req.body.id_sesion)
      )
    })

    if (filter.length !== 0) {
      res.send({
        status: 404,
        typo: 'error',
        messege: 'Ya existe una apertura de asistencia en este dia.',
        data: []
      })
      return
    }

    const result = await objasistencia.inser_apertureasistencia(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }

  // ACTUALIZAR EL ESTADO DE UNA ASISTENCIA DE INSCRIPCCION
  // 1: asistio, 2 : falto, 0: desconocido
  async actuali_stadoasisten (req, res) {
    console.log(req.body)
    // validar datos insertados
    const validado = Valideinsert(req)

    if (validado.valida) {
      res.send({
        status: 404,
        typo: 'error',
        messege: 'Se inserto un estado desconocido.',
        data: validado.auxvalidetdata
      })
      return
    }
    // insertar capturar el id del profesor
    await objasistencia.actuali_stadoasisten(req, res)
    const resultAddPoint = await objPointClass.inser_point_asisten(
      req,
      res,
      req.params.id_asisinscr,
      req.body.stade
    )
    res.send(resultAddPoint)
  }

  async list_apertureasistencia (req, res) {
    const result = await objasistencia.list_apertureasistencia(req, res)
    res.json(result)
  }

  async list_inscripasisten (req, res) {
    const result = await objasistencia.list_inscripasisten(req, res)
    res.json(result)
  }

  async delect_asistencia (req, res) {
    const dataResul = await objasistencia.delect_asistencia(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: dataResul
    })
  }
}
