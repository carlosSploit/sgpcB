const dbcone = require("../../config/bd/connet_mysql");
let conexibd = new dbcone();
//######################### dbcurso ###################################
module.exports = class dbadmin {
  async inser_puntosclass(req, res) {
    return this.add_puntosclass(req, res, [
      {
        name: req.body.name,
        valpoint: req.body.valpoint,
        photo: req.body.photo,
        id_prof: req.body.id_prof,
        isacumulable: req.body.isacumulable,
        isdefault: 0,
      },
    ]);
  }

  async inser_puntosclass_default(req, res, id_profe = 0) {
    return this.add_puntosclass(
      req,
      res,
      [
        {
          name: "Asistencia",
          valpoint: 1,
          photo: "1",
          id_prof: id_profe,
          isacumulable: 0,
          isdefault: 1,
        },
        {
          name: "Participacion",
          valpoint: 1,
          photo: "4",
          id_prof: id_profe,
          isacumulable: 1,
          isdefault: 1,
        },
        {
          name: "Resolvio Tarea",
          valpoint: 1,
          photo: "6",
          id_prof: id_profe,
          isacumulable: 1,
          isdefault: 1,
        },
      ],
      "Se cargaron los puntos por default"
    );
  }

  async add_puntosclass(
    req,
    res,
    data = [
      {
        name: "",
        valpoint: 0,
        photo: "1",
        id_prof: 0,
        isacumulable: 1,
        isdefault: 0,
      },
    ],
    messege = "Se inserto correctamente el punto de clase"
  ) {
    let results = messege;
    data.forEach(async (item) => {
      // console.log(item);
      results = await conexibd.single_query(
        req,
        res,
        "CALL `insert_pointclas`(?,?,?,?,?,?);",
        [
          item.name,
          item.valpoint,
          item.photo,
          item.id_prof,
          item.isacumulable,
          item.isdefault,
        ],
        messege
      );
    });
    return results;
  }

  async actualise_puntosclass(req, res) {
    let results = await conexibd.single_query(
      req,
      res,
      "CALL `update_pointclas`(?,?,?,?,?);",
      [
        req.body.name,
        req.body.valpoint,
        req.body.photo,
        req.params.id_puntosclass,
        req.body.isacumulable,
      ],
      "Se actualizo correctamente el punto de clase"
    );
    return results;
  }

  async list_puntosclass(req, res) {
    let results = this.getpuntosclass(req, res, req.params.id_prof);
    return results;
  }

  async getpuntosclass(req, res, id_prof = 0) {
    let results = await conexibd.single_query(
      req,
      res,
      "CALL `list_pointclas`(?);",
      [id_prof]
    );
    return Array.isArray(results) ? results : [];
  }

  async delect_puntosclass(req, res) {
    let results = await conexibd.single_query(
      req,
      res,
      "CALL `delect_pointclas`(?);",
      [req.params.id_puntosclass],
      "Se elimino el punto de clase con exito."
    );
    return results;
  }

  // valida si un punto es acumulable o no
  async valid_puntos_class(req, res, id_tipo_punt) {
    let result = await this.read_puntosclass(req, res, id_tipo_punt);
    let dataKeys = Object.keys(result);
    let keyfilter = dataKeys.filter((item) => {
      return item == "isacumulado";
    });
    return keyfilter.length != 0 ? result.isacumulado : -1;
  }

  async read_puntosclass(req, res, id_tipo_puntos) {
    // let results = await conexibd.single_query(req, res,'CALL `read_puntosclass`(?);',[req.params.id_puntosclass])
    let result = await this.getpuntosclass(req, res);
    let objPunt = result.filter((item) => {
      return item.id_tipo_puntos == id_tipo_puntos;
    });
    return objPunt.length == 0 ? { id_tipo_punt: 0 } : objPunt[0];
  }
};
