const dbcone = require("../../config/bd/connet_mysql");
let conexibd = new dbcone();
//######################### dbcurso ###################################
module.exports = class dbsesion {
  async list_tipoconte(req, res) {
    let results = await conexibd.single_query(
      req,
      res,
      "CALL `list_tipoconte`();",
      []
    );
    return Array.isArray(results) ? results : [];
  }
};
