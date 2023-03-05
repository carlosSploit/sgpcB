const Dbcone = require('../../../config/bd/connet_mysql')
const conexibd = new Dbcone()
// ######################### DbclientAnali ###################################
module.exports = class DbclientAnali {
  async inser_empresa (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `insert_empresa`(?,?,?,?,?,?,?,?);',
      [
        req.body.id_clienAnalit,
        req.body.nombreempresa,
        req.body.ruc,
        req.body.descripc,
        req.body.telefono,
        req.body.rubroempresa,
        req.body.misio,
        req.body.vision
      ],
      'Se inserto correctamente la empresa'
    )
    return results
  }

  async actualise_empresa (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `update_clientAnali`(?,?,?,?,?);',
      [
        req.body.nombre,
        req.body.apellidos,
        req.body.telf,
        req.body.photo,
        req.params.id_clienAnalit
      ],
      'Se actualizo correctamente el cliente analista'
    )
    return results
  }

  async list_empresa (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `list_empresa`(?);',
      [req.params.id_clienAnalit]
    )
    return Array.isArray(results) ? results : []
  }

  // async delect_admin (req, res) {
  //   const results = await conexibd.single_query(
  //     req,
  //     res,
  //     'CALL `delect_admin`(?);',
  //     [req.params.id_admin],
  //     'Se elimino el administrador con exito.'
  //   )
  //   return results
  // }

  async read_clienAnalit (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `read_clientAnali`(?);',
      [req.params.id_clienAnalit]
    )
    return Array.isArray(results) ? results : []
  }
}
