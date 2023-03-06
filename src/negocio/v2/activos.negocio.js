const Validator = require('../../../config/complementos/validator')
const objvalit = new Validator()
const Bdactivos = require('../../model/v2/activos.bd')
const objactivos = new Bdactivos()

const Valideinsert = (req) => {
  const valida =
    objvalit.validator_vacio(req.body.nombre_Activo) ||
    objvalit.validator_vacio(req.body.descripc)

  const dataarray = [
    {
      datacom: 'nombre_Activo',
      valide: objvalit.validator_vacio(req.body.nombre_Activo)
    },
    {
      datacom: 'descripc',
      valide: objvalit.validator_vacio(req.body.descripc)
    }
  ]

  const auxvalidetdata = dataarray.filter((item) => {
    return item.valide
  })
  console.log(auxvalidetdata)
  return { valida, auxvalidetdata }
}

module.exports = class ngactivo {
  async inser_activo (req, res) {
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

    const result = await objactivos.inser_activo(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }

  // async actualise_areasempresa (req, res) {
  //   // validar datos insertados
  //   const validado = Valideinsert(req)

  //   if (validado.valida) {
  //     res.send({
  //       status: 404,
  //       typo: 'error',
  //       messege: 'Casillas mal ingresadas',
  //       data: validado.auxvalidetdata
  //     })
  //     // eslint-disable-next-line no-useless-return
  //     return
  //   }

  //   // si todo esta correcto, inserta los datos
  //   const result = await objareasempresa.actualise_areasempresa(req, res)
  //   res.send({
  //     status: 200,
  //     typo: 'succes',
  //     messege: result
  //   })
  // }

  async list_activos (req, res) {
    const result = await objactivos.list_activos(req, res)
    res.json(result)
  }

  // async eliminar_areasempresa (req, res) {
  //   const result = await objareasempresa.eliminar_areasempresa(req, res)
  //   res.json(result)
  // }
}
