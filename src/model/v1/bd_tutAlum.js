const dbcone = require("../../config/bd/connet_mysql");
let conexibd = new dbcone();
//######################### dbcurso ###################################
module.exports = class dbtutor_alumno {
  async inser_tutAlum(req, res) {
    let results = await conexibd.single_query(
      req,
      res,
      "CALL `insert_tutAlumn`(?,?,?,?,?);",
      [
        req.body.name,
        req.body.correo,
        req.body.telf,
        req.body.photo,
        req.body.pass,
      ],
      "Se inserto el tutor con exito."
    );
    return results;
  }

  // async actuali_alumno(req,res){
  //     let results = await conexibd.single_query(req, res,'CALL `update_alumno`(?,?,?,?,?,?,?,?);',[ req.params.id_alumno,
  //                                                                                                req.body.name,
  //                                                                                                req.body.correo,
  //                                                                                                req.body.telf,
  //                                                                                                req.body.pass,
  //                                                                                                req.body.photo,
  //                                                                                                req.body.edad,
  //                                                                                                req.body.name_tutor], "Se a actualizado al alumno con exito");
  //     return results;
  // }

  async list_tutalum(req, res) {
    let results = await conexibd.single_query(
      req,
      res,
      "CALL `list_tutAlumn`();",
      []
    );
    return Array.isArray(results) ? results : [];
  }

  // async list_alumno(req,res){
  //     let result = await list_alumno(req,res);
  //     let
  // }

  // async delect_alumno(req,res){
  //     let results = await conexibd.single_query(req, res,'CALL `delect_alumno`(?);',[req.params.id_alumno],"Se elimino el alumno con exito.")
  //     return results;
  // }

  // isKeyExistsParems(req,key){
  //     console.log(req.params);
  //     //if (req.params == undefined) return false;
  //     if (req.params[key] == undefined ){
  //         return false;
  //     }else{
  //      return true;
  //     }
  // }

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
