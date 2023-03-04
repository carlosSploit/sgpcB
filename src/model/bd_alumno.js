const dbcone = require("../../config/bd/connet_mysql");
let conexibd = new dbcone();
//######################### dbcurso ###################################
module.exports = class dbalumno {
  async inser_alumno(req, res) {
    let results = await conexibd.single_query(
      req,
      res,
      "CALL `insert_alumno`(?,?,?,?,?,?,?,?);",
      [
        req.body.name,
        req.body.telf,
        req.body.correo,
        req.body.pass,
        req.body.photo,
        req.body.name_tutor,
        req.body.edad,
        req.body.id_tutor,
      ],
      "Se inserto el alumno con exito."
    );
    return results;
  }

  async actuali_alumno(req, res) {
    let results = await conexibd.single_query(
      req,
      res,
      "CALL `update_alumno`(?,?,?,?,?,?,?,?,?);",
      [
        req.params.id_alumno,
        req.body.name,
        req.body.correo,
        req.body.telf,
        req.body.pass,
        req.body.photo,
        req.body.edad,
        req.body.name_tutor,
        req.body.id_tutor,
      ],
      "Se a actualizado al alumno con exito"
    );
    return results;
  }

  async list_alumno(req, res) {
    let results = await conexibd.single_query(
      req,
      res,
      "CALL `list_alumno`(?);",
      [req.params.name == " " ? "" : req.params.name]
    );
    return Array.isArray(results) ? results : [];
  }

  async delect_alumno(req, res) {
    let results = await conexibd.single_query(
      req,
      res,
      "CALL `delect_alumno`(?);",
      [req.params.id_alumno],
      "Se elimino el alumno con exito."
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

  async read_alumno(req, res, id_alumno = 0) {
    let results = await conexibd.single_query(
      req,
      res,
      "CALL `read_alumno`(?);",
      [
        this.isKeyExistsParems(req, "id_alumno")
          ? req.params.id_alumno
          : id_alumno,
      ]
    );
    return Array.isArray(results) ? results : [];
  }

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
