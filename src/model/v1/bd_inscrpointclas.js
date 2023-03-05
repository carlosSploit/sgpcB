const dbcone = require("../../config/bd/connet_mysql");
const { groupby } = require("../../config/complementos/arrayprototype");
let conexibd = new dbcone();
//######################### dbcurso ###################################
module.exports = class dbinscripuntclas {
  async inser_inscripuntclas(req, res) {
    let results = await conexibd.single_query(
      req,
      res,
      "CALL `insert_inscripuntclas`(?,?,?);",
      [req.body.id_inscrip, req.body.id_tipopunt, req.body.id_sesion],
      "Se inserto correctamente el punto de clase"
    );
    return results;
  }

  async valider_inscpointclas(req, res) {
    let results = await conexibd.single_query(
      req,
      res,
      "CALL `valider_inscpointclas`(?,?,?);",
      [req.body.id_sesion, req.body.id_inscrip, req.body.id_tipopunt]
    );
    return Array.isArray(results) ? results : [];
  }

  async list_inscripuntclas(req, res) {
    let tipolist = req.params.tiposes;
    let id_tipolist = req.params.id_tiposes;
    let result = [];
    switch (tipolist) {
      // imprime los puntos de un inscrito por ciclo
      case "C":
        result = await conexibd.single_query(
          req,
          res,
          "CALL `list_inscripuntclas`(?,?,?);",
          [req.params.id_inscri, 0, id_tipolist]
        );
        let aux = [...result];
        result = groupby("id_sesion", aux);
        console.log(result);
        break;
      // imprime los puntos de un inscrito por seciom
      case "S":
        result = await conexibd.single_query(
          req,
          res,
          "CALL `list_inscripuntclas`(?,?,?);",
          [req.params.id_inscri, id_tipolist, 0]
        );
        // console.log(result);
        break;
      default:
        break;
    }

    return Array.isArray(result) ? result : [];
  }

  async delect_inscripuntclas(req, res) {
    let results = await conexibd.single_query(
      req,
      res,
      "CALL `delect_inscripuntclas`(?,?,?);",
      [req.body.id_sesion, req.body.id_inscrip, req.body.id_tipopunt],
      "Se elimino al inscrito el punto de clase con exito."
    );
    return results;
  }

  // async read_puntosclass(req,res){
  //     let results = await conexibd.single_query(req, res,'CALL `read_puntosclass`(?);',[req.params.id_puntosclass])
  //     return (Array.isArray(results))?results:[];
  // }
};
