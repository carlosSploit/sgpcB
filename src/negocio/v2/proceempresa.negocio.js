const Validator = require('../../../config/complementos/validator')
const objvalit = new Validator()
const Bdproceempresa = require('../../model/v2/proceempresa.bd')
const objproceempresa = new Bdproceempresa()

const Valideinsert = (req) => {
  const valida =
    objvalit.validator_vacio(req.body.nombreProce) ||
    objvalit.validator_vacio(req.body.descripccion) ||
    objvalit.validator_integer(req.body.id_gerarProc) ||
    objvalit.validator_integer(req.body.id_tipProce)

  const dataarray = [
    {
      datacom: 'nombreProce',
      valide: objvalit.validator_vacio(req.body.nombreProce)
    },
    {
      datacom: 'descripccion',
      valide: objvalit.validator_vacio(req.body.descripccion)
    },
    {
      datacom: 'id_gerarProc',
      valide: objvalit.validator_integer(req.body.id_gerarProc)
    },
    {
      datacom: 'id_tipProce',
      valide: objvalit.validator_integer(req.body.id_tipProce)
    }
  ]

  const auxvalidetdata = dataarray.filter((item) => {
    return item.valide
  })
  console.log(auxvalidetdata)
  return { valida, auxvalidetdata }
}

// const ValideCorreoandPassUpdate = async (req, res) => {
//   // se verifica que que no hayan cambios
//   const listinfoadmin = await objclienAnalit.read_admin(req, res)
//   const datainfoadmin = listinfoadmin[0]
//   console.log(datainfoadmin)
//   if (!(((datainfoadmin.correo + '') === (req.body.correo + '')) && ((datainfoadmin.pass + '') === (req.body.pass + '')))) {
//     const valideCorAndPass = await ValideCorreoandPass(req, res)
//     // si ya existe un usuario con el mismo correo y contraseña
//     if (valideCorAndPass.status === 404) return valideCorAndPass
//   }
//   // si no existe el usuario con el correo y contraseña
//   return {
//     status: 200
//   }
// }

module.exports = class ngproceempresa {
  async inser_proceempresa (req, res) {
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

    const result = await objproceempresa.inser_proceempresa(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }

  async actualise_proceempresa (req, res) {
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

    // si todo esta correcto, inserta los datos
    const result = await objproceempresa.actualise_proceempresa(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }

  async list_proceempresa (req, res, idEmpresa = -1) {
    const result = await objproceempresa.list_proceempresa(req, res, (parseInt(idEmpresa) === -1) ? req.params.id_empresa : idEmpresa)
    return result
  }

  async eliminar_proceempresa (req, res) {
    const result = await objproceempresa.eliminar_proceempresa(req, res)
    res.json(result)
  }
}
