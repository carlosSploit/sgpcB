const Validator = require('../../config/complementos/validator')
const objvalit = new Validator()
const variables = require('../../config/key.json')
const Bdinscripccion = require('../model/bd_inscripccion')
const Bdalumn = require('../model/bd_alumno')
const Bdciclocurs = require('../model/bd_ciclocurso')
const enviarmess = require('../../config/smtp/nodemulter/nodemulter')
const objinscrip = new Bdinscripccion()
const objalum = new Bdalumn()
const objciclo = new Bdciclocurs()

const Valideinsert = (req) => {
  const valida = objvalit.validator_url(req.body.urlvoucher)

  const dataarray = [
    {
      datacom: 'urlvoucher',
      valide: objvalit.validator_url(req.body.urlvoucher)
    }
  ]

  const auxvalidetdata = dataarray.filter((item) => {
    return item.valide
  })
  console.log(auxvalidetdata)
  return { valida, auxvalidetdata }
}

module.exports = class ngcurso {
  async insert_inscrip (req, res) {
    // validar datos insertados
    const validado = Valideinsert(req)

    if (validado.valida && (parseInt(req.body.idtipoinscrip) === 2)) {
      res.send({
        status: 404,
        typo: 'error',
        messege: 'casillas mal ingresadas',
        data: validado.auxvalidetdata
      })
      return
    }

    // valida si el el alumno ya se inscripbio al curso
    const valida = await objinscrip.valider_inscricurse(
      req,
      res,
      req.body.idalumno,
      req.body.idciclocur
    )
    if (valida.length !== 0) {
      res.send({
        status: 404,
        typo: 'error',
        messege: 'El usuario ya se registro al curso',
        data: []
      })
      return
    }

    // let results = await conexibd.single_query(req, res,'CALL `insert_admin`(?,?,?,?,?,?);',[req.body.name, req.body.telf, req.body.correo, req.body.pass, req.body.tipoadm, req.body.photo])
    // return (Array.isArray(results))?results:[];
    const alumn = await objalum.read_alumno(req, res, req.body.idalumno)
    // solo funcional con los curso con inscripccion
    req.params.name = '' // pasar parametro no nombre ya que no hay ese parametro
    const listciclocur = await objciclo.list_ciclocurs_to_listcourse(req, res)
    const objcicl = listciclocur.filter((item) => {
      return parseInt(item.id_ciclo_curso) === parseInt(req.body.idciclocur)
    })
    // let curso = await objciclo.read_ciclocurso(req,res,req.body.idciclocur);
    const curso = objcicl[0]

    try {
      if ((req.body.urlvoucher + '') !== '') {
        const messege = `El alumno ${alumn[0].nombre} se a inscrito al curso ${curso.nombre}, se esta esperando confirmacion de inscripcion.`
        const title = 'Registro de pre-inscripccion'
        enviarmess(variables.gmailcredencial.USSER, title, messege)
      } else {
        const messege = `Gracias por confiar en nosotros ${alumn[0].nombre} se a inscrito al curso ${curso.nombre}, sera un gran honor poderte enseñar todos nuestros conocimientos, y a su vez que puedas divertirte aprendiendo.`
        const title = 'Bienvenido al curso'
        enviarmess(alumn[0].correo, title, messege)
      }
    } catch (e) {
      console.log(e)
    }

    const result = await objinscrip.insert_inscrip(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }

  async valider_inscricurse (req, res) {
    // let results = await conexibd.single_query(req, res,'CALL `list_admin`(?);',[req.params.name])
    // return (Array.isArray(results))?results:[];
    const result = await objinscrip.valider_inscricurse(
      req,
      res,
      req.body.idalumno,
      req.body.idciclocur
    )
    res.json(result)
  }

  async list_inscrip_to_curso_alumno (req, res) {
    // let results = await conexibd.single_query(req, res,'CALL `list_admin`(?);',[req.params.name])
    // return (Array.isArray(results))?results:[];
    const result = await objinscrip.list_inscrip_to_curso_alumno(req, res)
    res.json(result)
  }

  async list_inscrip_the_alumno (req, res) {
    // let results = await conexibd.single_query(req, res,'CALL `list_admin`(?);',[req.params.name])
    // return (Array.isArray(results))?results:[];
    const result = await objinscrip.list_inscrip_the_alumno(req, res)
    res.json(result)
  }

  async list_preinscrip (req, res) {
    const result = await objinscrip.list_preinscrip(req, res)
    res.json(result)
  }

  async actualise_stado_inscrip (req, res) {
    // enviar correo de confirmacion de la inscripccion
    const listpreins = await objinscrip.list_preinscrip(req, res)
    const preins = listpreins.filter((item) => {
      return parseInt(item.id_inscrip) === parseInt(req.params.idinscrip)
    })
    const objpreins = preins[0]
    const messege = `Gracias por confiar en nosotros ${objpreins.nombre} se a inscrito al curso  ${objpreins.namecurso}, sera un gran honor poderte enseñar todos nuestros conocimientos, y a su vez que puedas divertirte aprendiendo.`
    const title = 'Aceptacion de inscripcciòn'
    // capturar el correo electronico para envio
    const alumn = await objalum.read_alumno(req, res, objpreins.id_alumno)
    enviarmess(alumn[0].correo, title, messege)
    // ------------------------------------------------
    const resul = await objinscrip.actualise_stado_inscrip(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: resul
    })
  }

  async delect_ciclocurso (req, res) {
    // let results = await conexibd.single_query(req, res,'CALL `delect_admin`(?);',[req.params.id_admin],"Se elimino un usuario.")
    // return res.send(results);
    const result = await objinscrip.delect_ciclocurso(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result,
      data: []
    })
  }

  async read_idinscrit_for_idconttar_and_idalumn (req, res) {
    // let results = await conexibd.single_query(req, res,'CALL `read_admin`(?);',[req.params.id_admin])
    // return (Array.isArray(results))?results:[];
    const result = await objinscrip.read_idinscrit_for_idconttar_and_idalumn(
      req,
      res
    )
    res.json(result[0])
  }
}
