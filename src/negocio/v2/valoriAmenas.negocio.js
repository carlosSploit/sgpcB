// const Validator = require('../../../config/complementos/validator')
// const objvalit = new Validator()
const BdvaloriAmenas = require('../../model/v2/valoriAmenas.bd')
const objvaloriAmenas = new BdvaloriAmenas()

// const Valideinsert = (req) => {
//   const valida =
//     objvalit.validator_integer(req.body.valorActivCuanti)

//   const dataarray = [
//     {
//       datacom: 'valorActivCuanti',
//       valide: objvalit.validator_integer(req.body.valorActivCuanti)
//     }
//   ]

//   const auxvalidetdata = dataarray.filter((item) => {
//     return item.valide
//   })
//   return { valida, auxvalidetdata }
// }

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

module.exports = class ngvaloriActiv {
  async insert_valorafectamen (req, res) {
    // validar datos insertados

    const result = await objvaloriAmenas.insert_valorafectamen(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }

  async actualizar_valorafectamen (req, res) {
    // validar datos insertados

    // si todo esta correcto, inserta los datos
    const result = await objvaloriAmenas.actualizar_valorafectamen(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }

  async list_valorafectamen (req, res) {
    const result = await objvaloriAmenas.list_valorafectamen(req, res)
    res.json(result)
  }

  // async eliminar_areasempresa (req, res) {
  //   const result = await objareasempresa.eliminar_areasempresa(req, res)
  //   res.json(result)
  // }
}
