const Validator = require('../../config/complementos/validator')
const objvalit = new Validator()

const Bdciclocurso = require('../model/bd_ciclocurso')
const objciclocurso = new Bdciclocurso()

const Valideinsert = (req) => {
  const valida =
    objvalit.validator_date(req.body.fech_in) ||
    objvalit.validator_date(req.body.fech_fin) ||
    objvalit.validator_date_men_date(req.body.fech_in, req.body.fech_fin) ||
    objvalit.validator_integer(req.body.disdu) ||
    objvalit.validator_date_range_day(
      req.body.fech_in,
      req.body.fech_fin,
      req.body.disdu
    ) ||
    objvalit.validator_decimal(req.body.presio)

  const dataarray = [
    {
      datacom: 'fech_in',
      valide: objvalit.validator_date(req.body.fech_in)
    },
    {
      datacom: 'fech_fin',
      valide: objvalit.validator_date(req.body.fech_fin)
    },
    {
      datacom: 'disdu',
      valide: objvalit.validator_integer(req.body.disdu)
    },
    {
      datacom: 'fech_in < fech_fin',
      valide: objvalit.validator_date_men_date(
        req.body.fech_in,
        req.body.fech_fin
      )
    },
    {
      datacom: 'disdu > (fech_fin - fech_in)',
      valide: objvalit.validator_date_range_day(
        req.body.fech_in,
        req.body.fech_fin,
        req.body.disdu
      )
    },
    {
      datacom: 'presio',
      valide: objvalit.validator_decimal(req.body.presio)
    }
  ]

  const auxvalidetdata = dataarray.filter((item) => {
    return item.valide
  })
  console.log(auxvalidetdata)
  return { valida, auxvalidetdata }
}

module.exports = class ngcurso {
  async inser_ciclocurso (req, res) {
    // validar datos insertados
    console.log(req.body)
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
    // validar si ya hay un ciclo insertado
    const validaresult = await objciclocurso.valide_ciclo_in_course(
      req,
      res,
      req.body.idcurso
    )

    if (validaresult.length !== 0) {
      res.send({
        status: 404,
        typo: 'error',
        messege:
          'Ya se presenta un ciclo insertado con este curso, si desea un cambio, actualizelo',
        data: []
      })
      return
    }

    // let results = await conexibd.single_query(req, res,'CALL `insert_admin`(?,?,?,?,?,?);',[req.body.name, req.body.telf, req.body.correo, req.body.pass, req.body.tipoadm, req.body.photo])
    // return (Array.isArray(results))?results:[];
    const result = await objciclocurso.inser_ciclocurs(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }

  async actuali_ciclocurso (req, res) {
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

    const result = await objciclocurso.actualise_ciclocurs(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }

  async list_ciclocurs_to_listcourse (req, res) {
    // let results = await conexibd.single_query(req, res,'CALL `list_admin`(?);',[req.params.name])
    // return (Array.isArray(results))?results:[];
    const result = await objciclocurso.list_ciclocurs_to_listcourse(req, res)
    res.json(result)
  }

  async list_ciclocurso_to_course (req, res) {
    // let results = await conexibd.single_query(req, res,'CALL `list_admin`(?);',[req.params.name])
    // return (Array.isArray(results))?results:[];
    const result = await objciclocurso.list_ciclocurso_to_course(req, res)
    res.json(result)
  }

  async delect_ciclocurso (req, res) {
    // let results = await conexibd.single_query(req, res,'CALL `delect_admin`(?);',[req.params.id_admin],"Se elimino un usuario.")
    // return res.send(results);
    const result = await objciclocurso.delect_ciclocurso(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result,
      data: []
    })
  }

  async read_ciclocurso (req, res) {
    // let results = await conexibd.single_query(req, res,'CALL `read_admin`(?);',[req.params.id_admin])
    // return (Array.isArray(results))?results:[];
    const result = await objciclocurso.read_ciclocurso(
      req,
      res,
      req.params.id_curso
    )
    res.json(result[0])
  }
}
