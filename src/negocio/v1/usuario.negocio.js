const enviarmess = require('../../../config/smtp/nodemulter/nodemulter')
const Bdusuario = require('../../model/bd_usuario')
const objusuario = new Bdusuario()

module.exports = class ngusuario {
  async compro_logusser (req, res) {
    const result = await objusuario.compro_logusser(
      req,
      res,
      req.body.usser,
      req.body.pass
    )
    res.json(result[0])
  }

  async compru_api_key (req, res) {
    const result = await objusuario.compru_api_key(req, res)
    res.json(result[0])
  }

  async compru_datasecion (req, res) {
    const result = await objusuario.compru_datasecion(req, res)
    res.json(result[0])
  }

  async compru_recpass (req, res) {
    const result = await objusuario.compru_recpass(req, res)
    let pass = ''
    let name = ''
    if (result.length !== 0) {
      pass = result[0].pass
      name = result[0].nombre
    }
    const messege = `Gracias por confiar en nosotros ${name}, tu contraseña es la siguiente: <b> ${pass} </b>`
    const title = 'Recuperar la contraseña'
    enviarmess(req.body.correo, title, messege)
    res.send('La contraseña se a insertado con exito')
  }

  async insert_singlog (req, res) {
    const result = await objusuario.insert_singlog(req, res)
    res.send(result[0])
  }
}
