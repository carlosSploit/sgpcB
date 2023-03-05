const dbcone = require("../../config/bd/connet_mysql");
let conexibd = new dbcone();
//######################### dbcurso ###################################
module.exports = class dbsesion {
  async inser_contesesion(req, res) {
    let results = await conexibd.single_query(
      req,
      res,
      "CALL `insert_contsession`(?,?,?,?,?);",
      [
        req.body.idsession,
        req.body.idtipocont,
        req.body.name,
        req.body.descr,
        req.body.urlcont,
      ],
      "Se inserto el contenido con exito."
    );
    return results;
  }

  async actualise_contesesion(req, res) {
    let results = await conexibd.single_query(
      req,
      res,
      "CALL `update_contsesion`(?,?,?,?,?);",
      [
        req.params.idconteses,
        req.body.idtipocont,
        req.body.name,
        req.body.descr,
        req.body.urlcont,
      ],
      "Se actualizo el contenido con exito."
    );
    return results;
  }

  async list_contesesion(req, res) {
    let results = await conexibd.single_query(
      req,
      res,
      "CALL `list_contsesi`(?);",
      [req.params.idsession]
    );
    return Array.isArray(results) ? results : [];
  }

  async delect_contesesion(req, res) {
    let results = await conexibd.single_query(
      req,
      res,
      "CALL `delect_contsessi`(?);",
      [req.params.idconteses],
      "Se elimino el contenido con exito."
    );
    return results;
  }
};
