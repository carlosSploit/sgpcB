const dbcone = require("../../config/bd/connet_mysql");
const bdcourse = require("./bd_curso");
const objcurso = new bdcourse();
let conexibd = new dbcone();
//######################### dbcurso ###################################
module.exports = class dbadmin {
  async insert_inscrip(req, res) {
    let results = await conexibd.single_query(
      req,
      res,
      "CALL `insert_inscrip`(?,?,?,?);",
      [
        req.body.idalumno,
        req.body.idciclocur,
        req.body.idtipoinscrip,
        req.body.urlvoucher,
      ],
      "Se inserto correctamente la inscripccion"
    );
    return results;
  }

  // async actualise_ciclocurs(req,res){
  //     let results = await conexibd.single_query(req, res,'CALL `update_ciclocurso`(?,?,?,?,?,?,?);',[req.params.idciclocur,
  //                                                                                                     req.body.idcurso,
  //                                                                                                     req.body.idprof,
  //                                                                                                     req.body.fech_in,
  //                                                                                                     req.body.fech_fin,
  //                                                                                                     req.body.disdu,
  //                                                                                                     req.body.presio],"Se actualizo correctamente el administradr")
  //     return results;
  // }

  async actualise_stado_inscrip(req, res) {
    let results = await conexibd.single_query(
      req,
      res,
      "CALL `update_stadeinscrip`(?,?);",
      [req.params.idinscrip, req.body.estade],
      "Actualizacion de estado completado"
    );
    return results;
  }

  // retorna dependiendo del alumno y del ciclo, si esque esta escrito
  async valider_inscricurse(req, res, id_alumno = 0, id_ciclcurso = 0) {
    let results = await conexibd.single_query(
      req,
      res,
      "CALL `valider_inscricurse`(?,?);",
      [id_alumno, id_ciclcurso]
    );
    return Array.isArray(results) ? results : [];
  }

  // lista todos los cursos que no esten eliminados y que este activos para inscripccion o el estado sea 1.
  async list_inscrip_to_curso_alumno(req, res) {
    // actualizar el estado de los ciclos en caso que sea nesesario
    // let resul = await this.actualise_stado_ciclocurs(req,res);
    // console.log(resul);
    //-------------------------------------------------------------
    let results = await conexibd.single_query(
      req,
      res,
      "CALL `list_inscri_curso`(?);",
      [req.params.id_alumn]
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

  // lista los inscritos/alumnos por un ciclo de curso
  async list_inscrip_the_alumno(req, res, id_ciclcurs) {
    // actualizar el estado de los ciclos en caso que sea nesesario
    // let resul = await this.actualise_stado_ciclocurs(req,res);
    // console.log(resul);
    //-------------------------------------------------------------
    let results = await conexibd.single_query(
      req,
      res,
      "CALL `list_inscri_alumn`(?);",
      [
        this.isKeyExistsParems(req, "id_ciclcurs")
          ? req.params.id_ciclcurs
          : id_ciclcurs,
      ]
    );
    return Array.isArray(results) ? results : [];
  }

  // Listar los ciclos de un curso en espesifico.
  async list_preinscrip(req, res) {
    let results = await conexibd.single_query(
      req,
      res,
      "CALL `list_preinscrip`();",
      []
    );
    return Array.isArray(results) ? results : [];
  }

  // async delect_ciclocurso(req,res){
  //     let results = await conexibd.single_query(req, res,'CALL `delect_ciclocurso`(?);',[req.params.idciclocur],"Se elimino un usuario.")
  //     return results;
  // }

  // Consular la id de un inscrito considerando la id del alumno y el id del contenido de tarea
  async read_idinscrit_for_idconttar_and_idalumn(req, res) {
    let results = await conexibd.single_query(
      req,
      res,
      "CALL `read_idinscripconttar`(?,?);",
      [req.body.idconttar, req.body.idalum]
    );
    return Array.isArray(results) ? results : [];
  }
};
