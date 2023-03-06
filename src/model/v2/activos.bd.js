const Dbcone = require('../../../config/bd/connet_mysql')
const conexibd = new Dbcone()
// ######################### DbclientAnali ###################################
module.exports = class DbclientAnali {
  async inser_activo (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `insert_activo`(?,?,?,?);',
      [
        req.body.nombre_Activo,
        req.body.descripc,
        req.body.id_empresa,
        req.body.id_tipoActiv
      ],
      'Se inserto correctamente el activo'
    )
    return results
  }

  // async actualise_clienAnalit (req, res) {
  //   const results = await conexibd.single_query(
  //     req,
  //     res,
  //     'CALL `update_clientAnali`(?,?,?,?,?);',
  //     [
  //       req.body.nombre,
  //       req.body.apellidos,
  //       req.body.telf,
  //       req.body.photo,
  //       req.params.id_clienAnalit
  //     ],
  //     'Se actualizo correctamente el cliente analista'
  //   )
  //   return results
  // }

  // async actuali_clienAnalitInfoUser (req, res) {
  //   const results = await conexibd.single_query(
  //     req,
  //     res,
  //     'CALL `update_clienAnalitInfoUser`(?,?,?,?);',
  //     [
  //       req.body.correo,
  //       req.body.username,
  //       req.body.pass,
  //       req.params.id_clienAnalit
  //     ],
  //     'Se actualizo el informacion de la cuenta correctamente el cliente analista'
  //   )
  //   return results
  // }

  async list_activos (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `list_activos`(?);',
      [req.params.id_empresa]
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

  // async read_clienAnalit (req, res) {
  //   const results = await conexibd.single_query(
  //     req,
  //     res,
  //     'CALL `read_clientAnali`(?);',
  //     [req.params.id_clienAnalit]
  //   )
  //   return Array.isArray(results) ? results : []
  // }
}
