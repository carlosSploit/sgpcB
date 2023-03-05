// const enviarmess = require('../../../config/smtp/nodemulter/nodemulter')
const Bdusuario = require('../../model/v2/usuario.bd')
const objusuario = new Bdusuario()
const { v4 } = require('uuid')
const jwt = require('jsonwebtoken')
const config = require('../../../config/config')

module.exports = class ngusuario {
  // async compro_logusser (req, res) {
  //   // const result = await objusuario.compro_logusser(
  //   //   req,
  //   //   res,
  //   //   req.body.usser,
  //   //   req.body.pass
  //   // )
  //   res.json('Su usuario y contrasena son correctos')
  // }

  // async compru_api_key (req, res) {
  //   // const result = await objusuario.compru_api_key(req, res)
  //   // res.json(result[0])
  //   res.send('Tu api key es sahdasjkdhaajajskdhjasdhakdhasjkhdaksj')
  // }

  // async compru_datasecion (req, res) {
  //   // const result = await objusuario.compru_datasecion(req, res)
  //   // res.json(result[0])
  //   res.send('ss datos son dhhasjkajadhjkajaskdhsjdakasd')
  // }

  // async compru_recpass (req, res) {
  //   // const result = await objusuario.compru_recpass(req, res)
  //   // let pass = ''
  //   // let name = ''
  //   // if (result.length !== 0) {
  //   //   pass = result[0].pass
  //   //   name = result[0].nombre
  //   // }
  //   // const messege = `Gracias por confiar en nosotros ${name}, tu contraseña es la siguiente: <b> ${pass} </b>`
  //   // const title = 'Recuperar la contraseña'
  //   // enviarmess(req.body.correo, title, messege)
  //   res.send('La contraseña se a insertado con exito')
  // }

  async insert_Infor_Secion (req, res) {
    const user = config.apidatkey
    const sessionKey = v4()
    // eslint-disable-next-line promise/param-names
    const apiKey = await new Promise((resol, reject) => {
      jwt.sign({ user }, 'secretkey', (err, token) => {
        if (err) reject(err)
        resol(token)
      })
    })
    // guardar informacion del inicio de secion
    req.body.infoSecion = { ...req.body.infoSecion, sessionKey, apiKey }
    await objusuario.insert_loginInfoUser(req, res)
    return {
      status: 200,
      typo: 'succes',
      messege: '',
      data: req.body.infoSecion
    }
  }

  async loginUser (req, res) {
    // se comprueba el inicio de secion
    const result = await objusuario.compruebe_loginUserbd(req, res)
    if (result.length === 0) {
      res.send({
        status: 404,
        typo: 'error',
        messege: 'Parece que el usuario y contrasena no existe',
        data: {}
      })
      return
    }
    // inserta la informacion del inicio de secion en memoria
    req.body.infoSecion = { id_usuario: result[0].id_usuario, tip_user: result[0].tip_user, id_inform: result[0].id_inform }
    const resultInserInfo = await this.insert_Infor_Secion(req, res)
    if (resultInserInfo.status === 400) {
      res.send({
        status: 404,
        typo: 'error',
        messege: 'Error al guardar informacion para el logueo del usuario',
        data: {}
      })
    }
    // res.send(result[0])
    res.send(resultInserInfo.data.sessionKey)
  }

  async read_loginApiKey (req, res) {
    const result = await objusuario.read_loginApiKey(req, res)
    if (result.length === 0) {
      res.send({
        status: 404,
        typo: 'error',
        messege: 'Parece que la seccion key no existe.',
        data: {}
      })
      return
    }
    res.send(result[0])
  }

  async read_loginInfoUser (req, res) {
    const result = await objusuario.read_loginInfoUser(req, res)
    if (result.length === 0) {
      res.send({
        status: 404,
        typo: 'error',
        messege: 'Parece que la seccion key no existe.',
        data: {}
      })
      return
    }
    res.send(result[0])
  }
}
