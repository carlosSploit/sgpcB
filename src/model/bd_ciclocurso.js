const dbcone = require("../../config/bd/connet_mysql");
const bdcourse = require("../model/bd_curso");
const objcurso = new bdcourse();
let conexibd = new dbcone();
//######################### dbcurso ###################################
module.exports = class dbadmin {
  async inser_ciclocurs(req, res) {
    let results = await conexibd.single_query(
      req,
      res,
      "CALL `insert_ciclocurso`(?,?,?,?,?,?);",
      [
        req.body.idcurso,
        req.body.idprof,
        req.body.fech_in,
        req.body.fech_fin,
        req.body.disdu,
        req.body.presio,
      ],
      "Se inserto el ciclo de curso con exito."
    );
    return results;
  }

  async actualise_ciclocurs(req, res) {
    let results = await conexibd.single_query(
      req,
      res,
      "CALL `update_ciclocurso`(?,?,?,?,?,?,?);",
      [
        req.params.idciclocur,
        req.body.idcurso,
        req.body.idprof,
        req.body.fech_in,
        req.body.fech_fin,
        req.body.disdu,
        req.body.presio,
      ],
      "Se actualizo el ciclo de curso con exito."
    );
    return results;
  }

  async actualise_stado_ciclocurs(req, res) {
    let results = await conexibd.single_query(
      req,
      res,
      "CALL `update_ciclocourseStade`();",
      [],
      "Actualizacion de estado completado."
    );
    return results;
  }

  // retornar el ciclo activo en ese instante, de un curso en espesifico
  async valide_ciclo_in_course(req, res, id_curso = 0) {
    let results = await conexibd.single_query(
      req,
      res,
      "CALL `valider_couse_ciclo`(?);",
      [id_curso]
    );
    return Array.isArray(results) ? results : [];
  }

  async list_ciclocurs_to_listcourse_complet(req, res) {
    // actualizar el estado de los ciclos en caso que sea nesesario
    let resul = await this.actualise_stado_ciclocurs(req, res);
    console.log(resul);
    //-------------------------------------------------------------
    let arraydata = [];
    let listcurso = await objcurso.list_curso(req, res);
    // si esta nulo se suspende la busqueda
    if (listcurso.length == 0) {
      return [];
    }
    // recorre los datos y retorna los cursos que tienen un ciclo inscrito
    for (let index = 0; index < listcurso.length; index++) {
      const element = listcurso[index];
      let datacourse = await this.read_ciclocurso(req, res, element.id_curso);
      arraydata.push(datacourse[0]);
    }
    return arraydata;
  }

  // lista todos los cursos que no esten eliminados y que este activos para inscripccion o el estado sea 1.
  async list_ciclocurs_to_listcourse(req, res) {
    // actualizar el estado de los ciclos en caso que sea nesesario
    let resul = await this.actualise_stado_ciclocurs(req, res);
    console.log(resul);
    //-------------------------------------------------------------
    let arraydata = [];
    let listcurso = await objcurso.list_curso(req, res);
    // si esta nulo se suspende la busqueda
    if (listcurso.length == 0) {
      return [];
    }
    // recorre los datos y retorna los cursos que tienen un ciclo inscrito
    for (let index = 0; index < listcurso.length; index++) {
      const element = listcurso[index];
      let datacourse = await this.read_ciclocurso(req, res, element.id_curso);
      if (datacourse.length != 0) {
        arraydata.push(datacourse[0]);
      }
    }
    return arraydata;
  }

  // Listar los ciclos de un curso en espesifico.
  async list_ciclocurso_to_course(req, res) {
    let results = await conexibd.single_query(
      req,
      res,
      "CALL `list_ciclocursoCurso`(?);",
      [req.params.id_curso]
    );
    return Array.isArray(results) ? results : [];
  }

  async delect_ciclocurso(req, res) {
    let results = await conexibd.single_query(
      req,
      res,
      "CALL `delect_ciclocurso`(?);",
      [req.params.idciclocur],
      "Se elimino un ciclo de curso con exito."
    );
    return results;
  }

  async read_ciclocurso(req, res, id_curso = 0) {
    let results = await conexibd.single_query(
      req,
      res,
      "CALL `read_ciclocurso`(?);",
      [id_curso]
    );
    return Array.isArray(results) ? results : [];
  }
};
