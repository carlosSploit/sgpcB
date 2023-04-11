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

  async inser_empresa_enlace (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `insert_empresa_enlace`(?,?,?);',
      [
        req.body.id_empresa,
        req.body.id_clienAnalit,
        req.body.permis
      ],
      'Se enlazo con la empresa correctamente'
    )
    return results
  }

  async actualise_empresa (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `update_empresa`(?,?,?,?,?,?,?,?);',
      [
        req.params.id_empresa,
        req.body.nombreempresa,
        req.body.ruc,
        req.body.descripc,
        req.body.telefono,
        req.body.rubroempresa,
        req.body.misio,
        req.body.vision
      ],
      'Se actualizo correctamente el empresa'
    )
    return results
  }

  async eliminar_empresa_enlace (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `delete_empresa_enlace`(?,?);',
      [
        req.params.id_empresa,
        req.params.id_clienAnalit
      ],
      'Se elimino correctamente el empresa'
    )
    return results
  }

  async list_empresa (req, res, idClienAnalit = 0) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `list_empresa`(?);',
      [(parseInt(idClienAnalit) === 0) ? req.params.id_clienAnalit : idClienAnalit]
    )
    return Array.isArray(results) ? results : []
  }

  // async list_empresa (req, res) {
  //   const results = await conexibd.single_query(
  //     req,
  //     res,
  //     'CALL `list_empresa`(?);',
  //     [req.params.id_clienAnalit]
  //   )
  //   return Array.isArray(results) ? results : []
  // }
}
