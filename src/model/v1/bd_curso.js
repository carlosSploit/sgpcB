const dbcone = require("../../config/bd/connet_mysql");
let conexibd = new dbcone();
//######################### dbcurso ###################################
module.exports = class dbcurso {
  async inser_curso(req, res) {
    let results = await conexibd.single_query(
      req,
      res,
      "CALL `insert_curso`(?,?,?,?,?,?);",
      [
        req.body.idtipcur,
        req.body.name,
        req.body.descr,
        req.body.alcan,
        req.body.contvid,
        req.body.photpo,
      ],
      "Se inserto el curso con exito"
    );
    return results;
  }

  async actuali_curso(req, res) {
    let results = await conexibd.single_query(
      req,
      res,
      "CALL `update_curso`(?,?,?,?,?,?,?);",
      [
        req.params.idcurso,
        req.body.idtipcur,
        req.body.name,
        req.body.descr,
        req.body.alcan,
        req.body.contvid,
        req.body.photpo,
      ],
      "Se a actualizado el curso con exito"
    );
    return results;
  }

  async list_curso(req, res) {
    let results = await conexibd.single_query(
      req,
      res,
      "CALL `list_curso`(?);",
      [req.params.name == " " ? "" : req.params.name]
    );
    return Array.isArray(results) ? results : [];
  }

  async delect_curso(req, res) {
    let results = await conexibd.single_query(
      req,
      res,
      "CALL `delect_curso`(?);",
      [req.params.idcurso],
      "Se elimino el curso con exito."
    );
    return results;
  }

  // async read_alumno(req,res){
  //     let results = await conexibd.single_query(req, res,'CALL `read_alumno`(?);',[req.params.id_alumno])
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
