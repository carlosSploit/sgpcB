const Dbcone = require('../../../config/bd/connet_mysql')
// const { v4 } = require('uuid')
// const jwt = require('jsonwebtoken')
// const config = require('../../../config/config')
const conexibd = new Dbcone()
// ######################### dbcurso ###################################
module.exports = class dbusuario {
  async compruebe_correo (req, res, correo = 'arturo14212000@gmail.com') {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `comp_correo`(?);',
      [correo]
    )
    return Array.isArray(results) ? results : []
  }

  async compruebe_correo_logIn (req, res, correo = 'arturo14212000@gmail.com') {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `comp_correo_login`(?);',
      [correo]
    )
    return Array.isArray(results) ? results : []
  }

  async compruebe_loginUserbd (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `comp_loginUserbd`(?,?);',
      [req.body.user, req.body.pass]
    )
    return Array.isArray(results) ? results : []
  }

  async insert_loginInfoUser (req, res) {
    const dataInfo = req.body.infoSecion
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `insert_loginInfoUser`(?,?,?);',
      [
        dataInfo.id_usuario,
        dataInfo.sessionKey,
        dataInfo.apiKey
      ],
      'Se inserto correctamente la insercion de la informacion.'
    )
    return results
  }

  async read_loginApiKey (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `read_loginApiKey`(?);',
      [req.body.seccionkey]
    )
    return Array.isArray(results) ? results : []
  }

  async read_loginInfoUser (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `read_loginInfoUser`(?);',
      [req.body.seccionkey]
    )
    return Array.isArray(results) ? results : []
  }
}
