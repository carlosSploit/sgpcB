const dbcone = require("../../config/bd/connet_mysql");
let conexibd = new dbcone();
//######################### dbcurso ###################################
module.exports = class dbadmin {
  async inser_admin(req, res) {
    let results = await conexibd.single_query(
      req,
      res,
      "CALL `insert_admin`(?,?,?,?,?,?);",
      [
        req.body.name,
        req.body.telf,
        req.body.correo,
        req.body.pass,
        req.body.tipoadm,
        req.body.photo,
      ],
      "Se inserto correctamente el administradr"
    );
    return results;
  }

  async actualise_admin(req, res) {
    let results = await conexibd.single_query(
      req,
      res,
      "CALL `update_admin`(?,?,?,?,?,?,?);",
      [
        req.params.id_admin,
        req.body.name,
        req.body.correo,
        req.body.telf,
        req.body.pass,
        req.body.photo,
        req.body.tipoadm,
      ],
      "Se actualizo correctamente el administradr"
    );
    return results;
  }

  async list_admin(req, res) {
    let results = await conexibd.single_query(
      req,
      res,
      "CALL `list_admin`(?);",
      [req.params.name == " " ? "" : req.params.name]
    );
    return Array.isArray(results) ? results : [];
  }

  async delect_admin(req, res) {
    let results = await conexibd.single_query(
      req,
      res,
      "CALL `delect_admin`(?);",
      [req.params.id_admin],
      "Se elimino el administrador con exito."
    );
    return results;
  }

  async read_admin(req, res) {
    let results = await conexibd.single_query(
      req,
      res,
      "CALL `read_admin`(?);",
      [req.params.id_admin]
    );
    return Array.isArray(results) ? results : [];
  }
};
