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

  async actualise_trabajempresa (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `update_trabajempresa`(?,?,?,?,?,?,?);',
      [
        req.body.nombre,
        req.body.cargo,
        req.body.descripc,
        req.body.telefono,
        req.body.correo,
        req.body.codTrabajo,
        req.params.id_trabajador
      ],
      'Se actualizo correctamente el empresa'
    )
    return results
  }

  async eliminar_trabEmpresa (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `delete_trabajempresa`(?);',
      [
        req.params.id_trabajador
      ],
      'Se elimino correctamente el empresa'
    )
    return results
  }

  async list_proceempresa (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `list_proceempresa`(?);',
      [
        req.params.id_empresa
      ]
    )
    return Array.isArray(results) ? results : []
  }
}
