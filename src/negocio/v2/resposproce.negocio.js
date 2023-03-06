const Bdresposproce = require('../../model/v2/resposproce.bd')
const objresposproce = new Bdresposproce()

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

module.exports = class ngclienAnalit {
  async inser_resposproce (req, res) {
    // validar datos insertados

    const result = await objresposproce.inser_resposproce(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }

  async list_areasempresa (req, res) {
    const result = await objresposproce.list_resposproce(req, res)
    res.json(result)
  }

  // async eliminar_areasempresa (req, res) {
  //   const result = await objareasempresa.eliminar_areasempresa(req, res)
  //   res.json(result)
  // }
}
