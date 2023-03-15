const Dbcone = require('../../../config/bd/connet_mysql')
const conexibd = new Dbcone()
// ######################### DbclientAnali ###################################
module.exports = class Dbactivprosveranali {
  async insert_activprosveranali (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `insert_activprosveranali`(?,?);',
      [
        req.body.id_versonAnali,
        req.body.id_activProc
      ],
      'Se inserto correctamente la empresa'
    )
    return results
  }

  async eliminar_activprosveranali (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `delete_activprosveranali`(?);',
      [
        req.params.id_activProsVerAnali
      ],
      'Se elimino correctamente el empresa'
    )
    return results
  }

  async read_activprosveranali (req, res, idActivProsVerAnali = 0) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `read_activprosveranali`(?);',
      [(parseInt(idActivProsVerAnali) === 0) ? req.params.id_activProsVerAnali : idActivProsVerAnali]
    )
    return Array.isArray(results) ? results : []
  }

  async list_activprosveranali (req, res, idVersonAnali = 0) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `list_activprosveranali`(?);',
      [(parseInt(idVersonAnali) === 0) ? req.params.id_versonAnali : idVersonAnali]
    )
    return Array.isArray(results) ? results : []
  }
// eslint-disable-next-line eol-last
}