const Dbcone = require('../../../config/bd/connet_mysql')
const conexibd = new Dbcone()
// ######################### DbclientAnali ###################################
module.exports = class DbclientAnali {
  // aperturar una valorizacion
  async insert_valorafectamen (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `insert_valorafectamen`(?,?);',
      [
        req.body.id_afectaActiv,
        req.body.id_escalaFrecuen
      ],
      'Se inserto correctamente la frecuencia de la amenaza'
    )
    return results
  }

  async actualizar_valorafectamen (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `update_valorafectamen`(?,?);',
      [
        req.params.id_valorAfectAmen,
        req.body.id_escalaFrecuen
      ],
      'Se actualizo correctamente el empresa'
    )
    return results
  }

  async loadProm_valorAfectAmen (req, res, idValorAfectAmen = 0) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `loadProm_valorAfectAmen`( ? );',
      [idValorAfectAmen],
      'Se actualizo correctamente el empresa'
    )
    return results
  }

  // async eliminar_valoriActiv (req, res) {
  //   const results = await conexibd.single_query(
  //     req,
  //     res,
  //     'CALL `delete_empresa_enlace`(?,?);',
  //     [
  //       req.params.id_empresa,
  //       req.params.id_clienAnalit
  //     ],
  //     'Se elimino correctamente el empresa'
  //   )
  //   return results
  // }

  async list_valorafectamen (req, res, idAfectaActiv = 0) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `list_valorafectamen`(?);',
      [(parseInt(idAfectaActiv) === 0) ? req.params.id_afectaActiv : idAfectaActiv]
    )
    return Array.isArray(results) ? results : []
  }

  async read_valorafectamen (req, res, idValorAfectAmen = 0) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `read_valorafectamen`(?);',
      [(parseInt(idValorAfectAmen) === 0) ? req.params.id_valorAfectAmen : idValorAfectAmen]
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
