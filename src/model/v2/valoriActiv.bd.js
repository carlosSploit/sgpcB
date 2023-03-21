const Dbcone = require('../../../config/bd/connet_mysql')
const conexibd = new Dbcone()
// ######################### DbclientAnali ###################################
module.exports = class DbclientAnali {
  async inser_valoriActiv (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `insert_valoractiv`(?,?);',
      [
        req.body.id_activProsVerAnali,
        req.body.valorActivCuanti
      ],
      'Se inserto correctamente la frecuencia de la amenaza'
    )
    return results
  }

  async actualizar_valoractiv (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `update_valoractiv`(?,?);',
      [
        req.params.id_valorActiv,
        req.body.valorActivCuanti
      ],
      'Se actualizo correctamente el empresa'
    )
    return results
  }

  async loadProm_valoractiv (req, res, idValorActiv = 0) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `loadProm_valoractiv`( ? );',
      [idValorActiv],
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

  async list_valoractiv (req, res, idActivProsVerAnali = 0) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `list_valoractiv`(?);',
      [(parseInt(idActivProsVerAnali) === 0) ? req.params.id_activProsVerAnali : idActivProsVerAnali]
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
