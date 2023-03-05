const dbcone = require("../../config/bd/connet_mysql");
let conexibd = new dbcone();
//######################### dbcurso ###################################
module.exports = class dbalumno {
  async inser_apertureasistencia(req, res) {
    let results = await conexibd.single_query(
      req,
      res,
      "CALL `insert_apertureasist`(?);",
      [req.body.id_sesion],
      "Se a aperurado una asistencia."
    );
    return results;
  }

  async actuali_stadoasisten(req, res) {
    let results = await conexibd.single_query(
      req,
      res,
      "CALL `update_stadoasisten`(?,?);",
      [req.params.id_asisinscr, req.body.stade],
      "Se a actualizado el estado de la asistencia."
    );
    return results;
  }

  async leer_asisten_info(req, res, id_asisinscrip = 0) {
    let results = await conexibd.single_query(
      req,
      res,
      "CALL `read_asisten_info`(?);",
      [id_asisinscrip == 0 ? req.params.id_asisinscrip : id_asisinscrip]
    );
    return results;
  }

  async list_apertureasistencia(req, res, id_ciclo) {
    let results = await conexibd.single_query(
      req,
      res,
      "CALL `list_apertureasis`(?);",
      [this.isKeyExistsParems(req, "id_ciclo") ? req.params.id_ciclo : id_ciclo]
    );
    return Array.isArray(results) ? results : [];
  }

  async list_inscripasisten(req, res, id_asisapert) {
    let results = await conexibd.single_query(
      req,
      res,
      "CALL `list_inscripasisten`(?);",
      [
        this.isKeyExistsParems(req, "id_asisapert")
          ? req.params.id_asisapert
          : id_asisapert,
      ]
    );
    return Array.isArray(results) ? results : [];
  }

  async delect_asistencia(req,res){
      let results = await conexibd.single_query(req, res,'CALL `delect_asistencia`(?);',[req.params.id_sesion],"Se elimino la asistencia con exito.")
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

  // async read_alumno(req,res,id_alumno = 0){
  //     let results = await conexibd.single_query(req, res,'CALL `read_alumno`(?);',[((this.isKeyExistsParems(req,"id_alumno"))?req.params.id_alumno:id_alumno)])
  //     return (Array.isArray(results))?results:[];
  // }

  // async eliminar(req,res){
  // }

  // async actualizar(req,res){
  //     let codeurl = req.body.codeurl;
  //     let nombre = req.body.nombre;
  //     let id = req.params.id;
  //     let results = await conexibd.single_query(req, res,'update categori_parti set nombre = ? , urlcode = ? where id = ? ;',
  //                                              [nombre,codeurl,id],
  //                                              "El participante se actualizado con exito")
  //     return res.send(results)
  // }
};
