const dbcone = require("../../config/bd/connet_mysql");
let conexibd = new dbcone();
//######################### dbcurso ###################################
module.exports = class dbsesion {
  async inser_sesion(req, res) {
    let results = await conexibd.single_query(
      req,
      res,
      "CALL `insert_sesion`(?,?);",
      [req.body.name, req.body.id_clcurso],
      "Se inserto la sesion con exito."
    );
    return results;
  }

  async actualise_sesion(req, res) {
    let results = await conexibd.single_query(
      req,
      res,
      "CALL `update_sesion`(?,?);",
      [req.params.id_sesion, req.body.name],
      "Se actualizo la sesion con exito."
    );
    return results;
  }

  async list_sesion(req, res) {
    let results = await conexibd.single_query(
      req,
      res,
      "CALL `list_sesion`(?);",
      [req.params.id_curso]
    );
    return Array.isArray(results) ? results : [];
  }

  async delect_sesion(req, res) {
    let results = await conexibd.single_query(
      req,
      res,
      "CALL `delect_sesion`(?);",
      [req.params.id_sesion],
      "Se elimino la sesion con exito."
    );
    return results;
  }
};
