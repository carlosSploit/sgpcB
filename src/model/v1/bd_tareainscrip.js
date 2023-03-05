const dbcone = require("../../config/bd/connet_mysql");
let conexibd = new dbcone();
//######################### dbcurso ###################################
module.exports = class dbsesion {
  async insert_tareainscr(req, res) {
    let results = await conexibd.single_query(
      req,
      res,
      "CALL `insert_tareainscr`(?,?,?);",
      [req.body.id_inscr, req.body.id_conttar, req.body.urlcont],
      "Se inserto la solucion de la tarea con exito."
    );
    return results;
  }

  async update_tareainsc(req, res) {
    let results = await conexibd.single_query(
      req,
      res,
      "CALL `update_tareainsc`(?,?);",
      [req.params.id_tarins, req.body.urlcont],
      "Se actualizo la solucion de la tarea con exito."
    );
    return results;
  }

  async update_tareainsc_to_puntos(req, res) {
    let results = await conexibd.single_query(
      req,
      res,
      "CALL `update_tareainsc_ponint`(?,?);",
      [req.params.id_tarins, req.body.point],
      "Se actualizo los puntos correctamente."
    );
    return results;
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

  async list_tareainscr(req, res, id_conttar = 0) {
    let results = await conexibd.single_query(
      req,
      res,
      "CALL `list_tareainscr`(?);",
      [
        this.isKeyExistsParems(req, "id_conttar")
          ? req.params.id_conttar
          : id_conttar,
      ]
    );
    return Array.isArray(results) ? results : [];
  }

  async list_tareainscr_ranking(req, res) {
    let results = await conexibd.single_query(
      req,
      res,
      "CALL `list_tareainscr_ranking`(?);",
      [req.params.id_ciclocur]
    );
    results = [
      ...results.map((item, ind) => {
        return { puesto: ind + 1, ...item };
      }),
    ];
    console.log(results);
    return Array.isArray(results) ? results : [];
  }

  async delect_tareainscr(req, res) {
    let results = await conexibd.single_query(
      req,
      res,
      "CALL `delect_tareainscr`(?);",
      [req.params.id_tareinsc],
      "Se elimino la solucion de la tarea con exito."
    );
    return results;
  }
};
