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

  // async compru_api_key (req, res) {
  //   const results = await conexibd.single_query(
  //     req,
  //     res,
  //     'CALL `compru_api_key`(?);',
  //     [req.body.seccionkey]
  //   )
  //   return Array.isArray(results) ? results : []
  // }

  // // CALL `Compru_datuserlog`(@p0);
  // async compru_datasecion (req, res) {
  //   const results = await conexibd.single_query(
  //     req,
  //     res,
  //     'CALL `Compru_datuserlog`(?);',
  //     [req.body.seccionkey]
  //   )
  //   return Array.isArray(results) ? results : []
  // }

  // async compru_recpass (req, res) {
  //   const results = await conexibd.single_query(
  //     req,
  //     res,
  //     'CALL `Compru_rescupass`(?);',
  //     [req.body.correo]
  //   )
  //   return Array.isArray(results) ? results : []
  // }

  // async insert_singlog (req, res) {
  //   const user = config.apidatkey
  //   const api_key = await new Promise((resol, reject) => {
  //     jwt.sign({ user }, 'secretkey', (err, token) => {
  //       if (err) reject(err)
  //       resol(token)
  //     })
  //   })
  //   const session_key = v4()
  //   console.log(`${api_key}/${session_key}`)
  //   const results = await conexibd.single_query(
  //     req,
  //     res,
  //     'CALL `insert_singlog`(?, ?, ? );',
  //     [req.body.id_usuario, v4(), api_key]
  //   )
  //   return Array.isArray(results) ? results : []
  // }

  // async eliminar(req,res){
  // }

  // async actualizar(req,res){
  //     let codeurl = req.body.codeurl;
  //     let nombre = req.body.nombre;
  //     let id = req.params.id;
  //     let results = await conexibd.single_query(req, res,'update categori_parti set nombre = ? , urlcode = ? where id = ? ;',
  //                                              [nombre,codeurl,id],
  //                                              "El participante se actualizado con exito")
  //     return res.send(results)
  // }
}
