const BdescalImpacResid = require('../../model/v2/escalImpacResid.bd')
const objescalImpacResid = new BdescalImpacResid()

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

module.exports = class ngescalaimpactoresidual {
  async inser_escalaimpactoresidual (req, res) {
    const result = await objescalImpacResid.inser_escalaimpactoresidual(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }

  async liest_escalaimpactoresidual (req, res) {
    const result = await objescalImpacResid.liest_escalaimpactoresidual(req, res)
    res.json(result)
  }
}
