const Validator = require('../../../config/complementos/validator')
const objvalit = new Validator()
const Bdinsidencias = require('../../model/v2/insidencias.bd')
const objinsidencias = new Bdinsidencias()

const Valideinsert = (req) => {
  const valida =
    objvalit.validator_vacio(req.body.nombreInsid) ||
    objvalit.validator_integer(req.body.id_activProc) ||
    objvalit.validator_integer(req.body.id_amenaza) ||
    objvalit.validator_vacio(req.body.descrpInsid)

  const dataarray = [
    {
      datacom: 'id_activProc',
      valide: objvalit.validator_integer(req.body.id_activProc)
    },
    {
      datacom: 'id_amenaza',
      valide: objvalit.validator_integer(req.body.id_amenaza)
    },
    {
      datacom: 'nombreInsid',
      valide: objvalit.validator_vacio(req.body.nombreInsid)
    },
    {
      datacom: 'descrpInsid',
      valide: objvalit.validator_vacio(req.body.descrpInsid)
    }
  ]

  const auxvalidetdata = dataarray.filter((item) => {
    return item.valide
  })
  console.log(auxvalidetdata)
  return { valida, auxvalidetdata }
}

module.exports = class nginsidencia {
  async inser_insidencia (req, res) {
    // validar datos insertados
    const validado = Valideinsert(req)

    if (validado.valida) {
      res.send({
        status: 404,
        typo: 'error',
        messege: 'Casillas mal ingresadas',
        data: validado.auxvalidetdata
      })
      // eslint-disable-next-line no-useless-return
      return
    }

    if ((parseInt(req.body.id_amenaza) === 0) || (parseInt(req.body.id_activProc) === 0)) {
      res.send({
        status: 404,
        typo: 'error',
        messege: 'La insidencia debe contener como minimo un activo y una amenaza enlazada.',
        data: validado.auxvalidetdata
      })
      return
    }

    const result = await objinsidencias.inser_insidencia(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }

  async actualise_insidencias (req, res) {
    // validar datos insertados
    const validado = Valideinsert(req)

    if (validado.valida) {
      res.send({
        status: 404,
        typo: 'error',
        messege: 'Casillas mal ingresadas',
        data: validado.auxvalidetdata
      })
      // eslint-disable-next-line no-useless-return
      return
    }

    if ((parseInt(req.body.id_amenaza) === 0) || (parseInt(req.body.id_activProc) === 0)) {
      res.send({
        status: 404,
        typo: 'error',
        messege: 'La insidencia debe contener como minimo un activo y una amenaza enlazada.',
        data: validado.auxvalidetdata
      })
      return
    }

    // si todo esta correcto, inserta los datos
    const result = await objinsidencias.actualise_insidencias(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }

  async list_insidencias (req, res) {
    const result = await objinsidencias.list_insidencias(req, res)
    res.json(result)
  }

  async eliminar_insidencias (req, res) {
    const result = await objinsidencias.delete_insidencias(req, res)
    res.json(result)
  }
}
