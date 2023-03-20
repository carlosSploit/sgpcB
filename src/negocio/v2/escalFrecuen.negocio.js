const BdescalFrecuen = require('../../model/v2/escalFrecuen.bd')
const objescalFrecuen = new BdescalFrecuen()

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

module.exports = class ngafectaDimem {
  async inser_escalFrecuen (req, res) {
    const result = await objescalFrecuen.inser_escalFrecuen(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }

  async list_escalafrecuencia (req, res) {
    const result = await objescalFrecuen.list_escalafrecuencia(req, res)
    res.json(result)
  }
}
