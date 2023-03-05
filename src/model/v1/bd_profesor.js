const dbcone = require("../../config/bd/connet_mysql");
let conexibd = new dbcone();
//######################### dbcurso ###################################
module.exports = class dbadmin {
  async inser_profe(req, res) {
    let results = await conexibd.single_query(
      req,
      res,
      "CALL `insert_profe`(?,?,?,?,?,?);",
      [
        req.body.name,
        req.body.telf,
        req.body.correo,
        req.body.pass,
        req.body.photo,
        req.body.estudios,
      ]
    );
    // console.log(results);
    return results;
  }

  async actuali_profe(req, res) {
    let results = await conexibd.single_query(
      req,
      res,
      "CALL `update_profesor`(?,?,?,?,?,?,?);",
      [
        req.params.id_profe,
        req.body.name,
        req.body.telf,
        req.body.correo,
        req.body.pass,
        req.body.photo,
        req.body.estudios,
      ],
      "Se a actualizado correctamente el profesor"
    );
    return results;
  }

  async list_profe(req, res) {
    let results = await conexibd.single_query(
      req,
      res,
      "CALL `list_profe`(?);",
      [req.params.name == " " ? "" : req.params.name]
    );
    return Array.isArray(results) ? results : [];
  }

  async delect_profe(req, res) {
    let results = await conexibd.single_query(
      req,
      res,
      "CALL `delect_profe`(?);",
      [req.params.id_profe],
      "Se elimino al profesor con exito."
    );
    return results;
  }

  async read_profe(req, res) {
    let results = await conexibd.single_query(
      req,
      res,
      "CALL `read_profe`(?);",
      [req.params.id_profe]
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
