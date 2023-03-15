const BdtipoAmenas = require('../../model/v2/tipoAmenas.bd')
const objtipoAmenas = new BdtipoAmenas()

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

module.exports = class ngtipProce {
  async inser_tipoamen (req, res) {
    const result = await objtipoAmenas.inser_tipoamen(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }

  async list_tipoAmenasa (req, res) {
    const result = await objtipoAmenas.list_tipoAmenasa(req, res)
    res.json(result)
  }
}
