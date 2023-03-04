const Validator = require('../../config/complementos/validator')
const objvalit = new Validator()
const BdInscripPointClass = require('./inscrpointclas.negocio')
const objInscripPointClass = new BdInscripPointClass()
const BdAsisteInscrip = require('../model/bd_asistencia')
const objAsisInsc = new BdAsisteInscrip()
const Bdpointclass = require('../model/bd_puntosclass')
const objadmin = new Bdpointclass()
const Bdpointinscrip = require('../model/bd_inscrpointclas')
const objpointinscrip = new Bdpointinscrip()

const Valideinsert = (req) => {
  const valida =
    objvalit.validator_vacio(req.body.name) ||
    objvalit.validator_vacio(req.body.valpoint) ||
    objvalit.validator_integer(req.body.isacumulable) // ||
  // objvalit.validator_url(req.body.photo)

  const dataarray = [
    {
      datacom: 'name',
      valide: objvalit.validator_vacio(req.body.name)
    },
    {
      datacom: 'valpoint',
      valide: objvalit.validator_vacio(req.body.valpoint)
    },
    {
      datacom: 'isacumulable',
      valide: objvalit.validator_integer(req.body.isacumulable)
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

const ValideInserPointAsistIncrip = async (req, res) => {
  // filtar los puntos que sean predeterminados
  const listdatapointprofesor = req.params.listPoints
  const listpointdefault = listdatapointprofesor.filter((item) => {
    return (
      parseInt(item.isdefault) === 1 &&
      parseInt(item.stade) === 1
    )
  }).map((item) => item.id_tipo_puntos)
  // lista los puntos de un alumno
  const listdatapoint = await objpointinscrip.list_inscripuntclas(req, res)
  // si no tiene ningun punto, retorna un mensaje sin datos
  if (listdatapoint.length === 0) {
    return {
      status: 200,
      typo: 'succes',
      messege:
        'Se a actualizado la asistencia correctamente.',
      data: []
    }
  }
  // filtra los puntos insertados y verefica si uno de estos es dafault
  const listpointpunAsist = listdatapoint.filter((item) => {
    // console.log(`point : ${parseInt(item.id_tipo_puntos)} stade: ${(listpointdefault.indexOf(parseInt(item.id_tipo_puntos)) !== -1)}`)
    return (
      listpointdefault.indexOf(parseInt(item.id_tipo_puntos)) !== -1 &&
      (item.nombre + '').toUpperCase().indexOf('ASISTENCIA') !== -1
    )
  })
  return {
    status: 200,
    typo: 'succes',
    messege: '',
    data: listpointpunAsist
  }
}

const ValideIdAsistencia = async (req, res, idAsistInscrip = 0) => {
  const listDataAsisInscrip = await objAsisInsc.leer_asisten_info(
    req,
    res,
    idAsistInscrip
  )
  if (listDataAsisInscrip.length === 0) {
    return {
      status: 404,
      typo: 'error',
      messege:
        'La asistencia se actualizo con exito , pero el id de la asistencia del inscrito parece ser que no existe;',
      data: []
    }
  }
  return {
    status: 200,
    typo: 'succes',
    messege: '',
    data: listDataAsisInscrip
  }
}

module.exports = class ngpointclass {
  async inser_pointclass (req, res) {
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
    const result = await objadmin.inser_puntosclass(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }

  async inser_pointclass_default_methond (req, res, idprofe = 0) {
    // validar datos insertados
    const listpointdefault = await objadmin.getpuntosclass(req, res, idprofe)
    const listpointpunt = listpointdefault.filter((item) => {
      return parseInt(item.isdefault) === 1 && parseInt(item.stade) === 1
    })
    // console.log(listpointpunt);
    if (listpointpunt.length > 0) {
      return {
        status: 404,
        typo: 'error',
        messege:
          'Los puntos de clase de forma predeterminada, ya fueron designados',
        data: [
          {
            datacom: 'id_prof',
            valide: false
          }
        ]
      }
    }
    // si todo esta correcto retorna los datos
    // let results = await conexibd.single_query(req, res,'CALL `insert_admin`(?,?,?,?,?,?);',[req.body.name, req.body.telf, req.body.correo, req.body.pass, req.body.tipoadm, req.body.photo])
    // return (Array.isArray(results))?results:[];
    const result = await objadmin.inser_puntosclass_default(req, res, idprofe)
    return {
      status: 200,
      typo: 'succes',
      messege: result
    }
  }

  // ACTUALIZAR EL ESTADO DE UNA ASISTENCIA DE INSCRIPCCION
  // 1: asistio, 2 : falto, 0: desconocido
  async inser_point_asisten (req, res, idasisinscr = 0, stade = 0) {
    // valida si el punto de asistencia existe
    const validIdAsis = await ValideIdAsistencia(req, res, idasisinscr)
    if (validIdAsis.status === 404) return validIdAsis
    // capturar los puntos que presennta disponible el profesor
    const listDataAsisInscrip = validIdAsis.data
    const dataAsisInscrip = listDataAsisInscrip[0]
    const listpointdefault = await objadmin.getpuntosclass(
      req,
      res,
      dataAsisInscrip.id_profesor
    )
    // #############################################################  si se da una falta
    if (stade === 2 || stade === 0) {
      // capturar los datos para validacion de punto ya insertado
      req.params.listPoints = listpointdefault
      req.params.id_inscri = dataAsisInscrip.id_inscrip
      req.params.id_tiposes = dataAsisInscrip.id_sesion
      req.params.tiposes = 'S'
      // valida si el punto de asistencia fue designado ya al alumno
      const validatInserPointAs = await ValideInserPointAsistIncrip(req, res)
      if (validatInserPointAs.data.length === 0) return validatInserPointAs
      // Se captura los datos de eliminacion
      const datInserPointAs = validatInserPointAs.data[0]
      req.body.id_inscrip = dataAsisInscrip.id_inscrip
      req.body.id_tipopunt = datInserPointAs.id_tipo_puntos
      req.body.id_sesion = dataAsisInscrip.id_sesion
      const result = await objpointinscrip.delect_inscripuntclas(req, res)
      console.log(result)
      // console.log(listDataAsisInscrip)
      return {
        status: 200,
        typo: 'succes',
        messege:
          'Se a actualizado la asistencia.',
        data: []
      }
    }
    // #############################################################  si se da una asistencia
    // capturar el puntaje de un profesor predeterminados que sean de asistencia
    const listpointpunt = listpointdefault.filter((item) => {
      return (
        parseInt(item.isdefault) === 1 &&
        parseInt(item.stade) === 1 &&
        (item.nombre + '').toUpperCase().indexOf('ASISTENCIA') !== -1
      )
    })
    // valida si esque existe el puntaje de asistencia
    if (listpointpunt.length === 0) {
      return {
        status: 404,
        typo: 'error',
        messege:
          'Se a actualizado la asistencia correctamente, pero no se presenta un puntaje predeterminado.',
        data: [
          {
            datacom: 'id_prof',
            valide: false
          }
        ]
      }
    }
    const dataPoint = listpointpunt[0]
    // ################################################################# Dar un punto a insertar al alumno
    req.body.id_inscrip = dataAsisInscrip.id_inscrip
    req.body.id_tipopunt = dataPoint.id_tipo_puntos
    req.body.id_sesion = dataAsisInscrip.id_sesion
    const result = await objInscripPointClass.add_inscripuntclas(req, res)
    // console.log(req.body)
    if (result.status === 404) {
      return {
        status: 404,
        typo: 'error',
        messege:
          'Se a actualizado la asistencia correctamente, pero no se inserto el puntaje de asistencia al inscrito.',
        data: []
      }
    }
    return {
      status: 200,
      typo: 'succes',
      messege:
        'Se a actualizado la asistencia e ingresado el punto de asistencia correctamente.',
      data: []
    }
  }

  async inser_pointclass_default (req, res) {
    const resultData = await this.inser_pointclass_default_methond(
      req,
      res,
      req.body.id_prof
    )
    return res.send(resultData)
  }

  async actuali_pointclass (req, res) {
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
    // si todo esta correcto valida
    // let results = await conexibd.single_query(req, res,'CALL `insert_admin`(?,?,?,?,?,?);',[req.body.name, req.body.telf, req.body.correo, req.body.pass, req.body.tipoadm, req.body.photo])
    // return (Array.isArray(results))?results:[];
    const result = await objadmin.actualise_puntosclass(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }

  async list_puntosclass (req, res) {
    // let results = await conexibd.single_query(req, res,'CALL `list_admin`(?);',[req.params.name])
    // return (Array.isArray(results))?results:[];
    const result = await objadmin.list_puntosclass(req, res)
    res.json(result)
  }

  async delect_puntosclass (req, res) {
    // valida si el numero o el id del punto existe dentro de la lista
    const listDataItem = await objadmin.getpuntosclass(req, res, 0)
    const dataItemFilter = listDataItem.filter(
      (item) => {
        // console.log(`Id list: ${parseInt(item.id_tipo_puntos)}  Id Punto: ${parseInt(req.params.id_puntosclass)} stade: ${}`)
        return parseInt(item.id_tipo_puntos) === parseInt(req.params.id_puntosclass)
      }
    )
    // console.log(`Id del punto a eliminar: ${req.params.id_puntosclass}`)
    // console.log(dataItemFilter)
    if (parseInt(dataItemFilter.length) === 0) {
      res.send({
        status: 404,
        typo: 'error',
        messege: 'El id del tipo de punto no existe.',
        data: [
          {
            datacom: 'id_puntosclass',
            valide: true
          }
        ]
      })
      return
    }
    // valida si es predeterminado o no
    const data = { ...dataItemFilter[0] }
    if (parseInt(data.isdefault) === 1) {
      res.send({
        status: 404,
        typo: 'error',
        messege:
          'El punto seleccionado es predeterminado y no se puede eliminar.',
        data: [
          {
            datacom: 'id_puntosclass',
            valide: true
          }
        ]
      })
      return
    }
    // si pasa todas las validaciones se da la eliminacion.
    const result = await objadmin.delect_puntosclass(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }
}
