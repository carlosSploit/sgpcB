const dbcone = require("../../config/bd/connet_mysql");
let conexibd = new dbcone();
//######################### dbcurso ###################################
module.exports = class dbadmin {
  async list_analiticas_ciclo_sincrono(req, res) {
    console.log("analitic_ciclo_sincrono_pru");
    let results = await conexibd.single_query(
      req,
      res,
      "CALL `analitic_ciclo_sincrono_pru`(?);",
      [req.params.idcurso]
    );
    return Array.isArray(results) ? results : [];
  }

  async list_analiticas_ciclo_sincrono_puntos(req, res) {
    let results = await conexibd.single_query(
      req,
      res,
      "CALL `analitic_ciclo_sincrono_puntos`(?);",
      [req.params.idcurso]
    );
    // convertir los puntos nulos en 0, sino se convertiran en el mismo punto
    if (!Array.isArray(results)) return []
    results = results.map((item) => {
      let itemdat = { ...item };
      itemdat["sumatotal"] =
        itemdat["sumatotal"] == null ? 0 : itemdat["sumatotal"];
      return itemdat;
    });
    // console.log(results);
    return Array.isArray(results) ? results : [];
  }
};
