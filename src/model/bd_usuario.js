const dbcone = require("../../config/bd/connet_mysql");
const { v4 } = require("uuid");
const jwt = require("jsonwebtoken");
const config = require("../../config/config");
let conexibd = new dbcone();
//######################### dbcurso ###################################
module.exports = class dbusuario {
  async compro_logusser(req, res, usser, pass) {
    let results = await conexibd.single_query(
      req,
      res,
      "CALL `compru_logusser`(?,?);",
      [usser, pass]
    );
    return Array.isArray(results) ? results : [];
  }

  async compru_api_key(req, res) {
    let results = await conexibd.single_query(
      req,
      res,
      "CALL `compru_api_key`(?);",
      [req.body.seccionkey]
    );
    return Array.isArray(results) ? results : [];
  }

  //CALL `Compru_datuserlog`(@p0);
  async compru_datasecion(req, res) {
    let results = await conexibd.single_query(
      req,
      res,
      "CALL `Compru_datuserlog`(?);",
      [req.body.seccionkey]
    );
    return Array.isArray(results) ? results : [];
  }

  async compru_recpass(req, res) {
    let results = await conexibd.single_query(
      req,
      res,
      "CALL `Compru_rescupass`(?);",
      [req.body.correo]
    );
    return Array.isArray(results) ? results : [];
  }

  async insert_singlog(req, res) {
    const user = config.apidatkey;
    let api_key = await new Promise((resol, reject) => {
      jwt.sign({ user }, "secretkey", (err, token) => {
        if (err) reject(err);
        resol(token);
      });
    });
    let session_key = v4();
    console.log(`${api_key}/${session_key}`);
    let results = await conexibd.single_query(
      req,
      res,
      "CALL `insert_singlog`(?, ?, ? );",
      [req.body.id_usuario, v4(), api_key]
    );
    return Array.isArray(results) ? results : [];
  }

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
};
