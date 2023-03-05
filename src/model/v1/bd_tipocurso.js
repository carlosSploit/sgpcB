const dbcone = require("../../config/bd/connet_mysql");
let conexibd = new dbcone();
//######################### dbcurso ###################################
module.exports = class dbtipotrabaj {
  async inser_tipocurso(req, res) {
    let results = await conexibd.single_query(
      req,
      res,
      "CALL `insert_tipocurso`(?);",
      [req.body.name],
      "Se inserto el tipo de curso con exito"
    );
    return results;
  }

  async actualise_tipocurso(req, res) {
    let results = await conexibd.single_query(
      req,
      res,
      "CALL `update_tipocurso`(?,?);",
      [req.params.id_tipocurso, req.body.name],
      "Se actualizo el tipo de curso con exito"
    );
    return results;
  }

  async list_tipocurso(req, res) {
    let results = await conexibd.single_query(
      req,
      res,
      "CALL `list_tipocurso`();",
      []
    );
    return Array.isArray(results) ? results : [];
  }

  async delect_tipocurso(req, res) {
    let results = await conexibd.single_query(
      req,
      res,
      "CALL `delect_tipocurso`(?);",
      [req.params.id_tipocurso],
      "Se elimino el tipo de curso con exito."
    );
    return results;
  }

  // async read_admin(req,res){
  //     let results = await conexibd.single_query(req, res,'CALL `read_admin`(?);',[req.params.id_admin])
  //     return (Array.isArray(results))?results:[];
  // }
};
