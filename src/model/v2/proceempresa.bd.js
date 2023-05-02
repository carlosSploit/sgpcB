const Dbcone = require('../../../config/bd/connet_mysql')
const conexibd = new Dbcone()
// ######################### DbclientAnali ###################################
module.exports = class Dbproceempresa {
  async inser_proceempresa (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `insert_proceempresa`(?,?,?,?,?,?,?);',
      [
        req.body.nombreProce,
        req.body.descripccion,
        req.body.id_gerarProc,
        req.body.id_tipProce,
        req.body.isDepProcPadre,
        req.body.id_DepentProc,
        req.body.id_empresa
      ],
      'Se inserto correctamente el proceso de la empresa'
    )
    return results
  }

  async actualise_proceempresa (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `update_proceempresa`(?,?,?,?,?,?,?);',
      [
        req.body.nombreProce,
        req.body.descripccion,
        req.body.id_gerarProc,
        req.body.id_tipProce,
        req.body.isDepProcPadre,
        req.body.id_DepentProc,
        req.params.id_proceso
      ],
      'Se actualizo correctamente el proceso de la empresa'
    )
    return results
  }

  async eliminar_proceempresa (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `delete_proceempresa`(?);',
      [
        req.params.id_proceso
      ],
      'Se elimino correctamente el proceso de la empresa'
    )
    return results
  }

  async list_proceempresa (req, res, idEmpresa = -1) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `list_proceempresa`(?);',
      [
        (parseInt(idEmpresa) === -1) ? req.params.id_empresa : idEmpresa
      ]
    )
    return Array.isArray(results) ? results : []
  }
}
