const Dbcone = require('../../../config/bd/connet_mysql')
const conexibd = new Dbcone()
// ######################### DbclientAnali ###################################
module.exports = class DbobjVersioAnalis {
  async insert_passalvafect (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `insert_passalvafect`(?,?);',
      [
        req.body.id_salvAfectAct,
        req.body.nombreSalvAfec
      ],
      'Se inserto correctamente el paso para el desarrollo de la estrategia.'
    )
    return results
  }

  async actualise_passalvafect (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `update_passalvafect`(?,?);',
      [
        req.params.id_pasSalvAfec,
        req.body.nombreSalvAfec
      ],
      'Se actualizo correctamente el paso para el desarrollo de la estrategia.'
    )
    return results
  }

  async eliminar_passalvafect (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `delete_passalvafect`( ? );',
      [
        req.params.id_pasSalvAfec
      ],
      'Se elimino correctamente el paso para el desarrollo de la estrategia.'
    )
    return results
  }

  async list_passalvafect (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `list_passalvafect`(?);',
      [req.params.id_salvAfectAct]
    )
    return Array.isArray(results) ? results : []
  }
}
