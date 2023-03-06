const Dbcone = require('../../../config/bd/connet_mysql')
const conexibd = new Dbcone()
// ######################### DbclientAnali ###################################
module.exports = class DbtrabEmpresa {
  async inser_trabajempresa (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `insert_trabajempresa`(?,?,?);',
      [
        req.body.nombre,
        req.body.cargo,
        req.body.descripc,
        req.body.telefono,
        req.body.correo,
        req.body.codTrabajo,
        req.body.id_empresa
      ],
      'Se inserto correctamente la empresa'
    )
    return results
  }

  async actualise_trabajempresa (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `update_trabajempresa`(?,?,?);',
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

  async list_trabEmpresa (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `list_trabajempresa`(?);',
      [
        req.params.id_empresa
      ]
    )
    return Array.isArray(results) ? results : []
  }
}
