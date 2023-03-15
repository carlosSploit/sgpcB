const BdafectaDimem = require('../../model/v2/afectaDimem.bd')
const objafectaDimem = new BdafectaDimem()

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
  async inser_afectaDimem (req, res) {
    const result = await objafectaDimem.inser_afectaDimem(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }

  async list_afectaDimem (req, res) {
    const result = await objafectaDimem.list_afectaDimem(req, res)
    res.json(result)
  }
}
