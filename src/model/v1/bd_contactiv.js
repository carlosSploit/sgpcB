const dbcone = require("../../config/bd/connet_mysql");
let conexibd = new dbcone();
//######################### dbcurso ###################################
module.exports = class dbsesion {
  async inser_contactiva(req, res) {
    let results = await conexibd.single_query(
      req,
      res,
      "CALL `insert_conttarea`(?,?,?,?);",
      [req.body.idsession, req.body.name, req.body.descr, req.body.urlcont],
      "Se inserto la tarea con exito."
    );
    return results;
  }

  async actualise_contactiva(req, res) {
    let results = await conexibd.single_query(
      req,
      res,
      "CALL `update_conttarea`(?,?,?,?);",
      [req.params.idcontactv, req.body.name, req.body.descr, req.body.urlcont],
      "Se actualizo la tarea con exito."
    );
    return results;
  }

  async list_contactiva(req, res) {
    let results = await conexibd.single_query(
      req,
      res,
      "CALL `list_conttarea`(?);",
      [req.params.idsession]
    );
    return Array.isArray(results) ? results : [];
  }

  isKeyExistsParems(req, key) {
    console.log(req.params);
    //if (req.params == undefined) return false;
    if (req.params[key] == undefined) {
      return false;
    } else {
      return true;
    }
  }

  async read_contactiva(req, res, id_conttar = 0) {
    let results = await conexibd.single_query(
      req,
      res,
      "CALL `read_conttarea`(?);",
      [
        this.isKeyExistsParems(req, "id_conttar")
          ? req.params.id_conttar
          : id_conttar,
      ]
    );
    return Array.isArray(results) ? results : [];
  }

  async delect_contactiva(req, res) {
    let results = await conexibd.single_query(
      req,
      res,
      "CALL `delect_conttarea`(?);",
      [req.params.idcontactv],
      "Se elimino la tarea con exito."
    );
    return results;
  }
};
