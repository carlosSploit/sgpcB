const Dbcone = require('../../../config/bd/connet_mysql')
const conexibd = new Dbcone()
// ######################### DbclientAnali ###################################
module.exports = class Dbareainterproce {
  async insert_responSalvAfectAct (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `insert_responSalvAfectAct`(?,?);',
      [
        req.body.id_salvAfectAct,
        req.body.id_trabajador
      ],
      'Se inserto correctamente el responsable de la salvaguarda'
    )
    return results
  }

  async eliminar_responSalvAfectAct (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `delete_responSalvAfectAct`( ? );',
      [
        req.params.id_responSalvAfectAct
      ],
      'Se elimino correctamente el empresa'
    )
    return results
  }

  async list_responSalvAfectAct (req, res, idSalvAfectAct = 0) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `list_responSalvAfectAct`(?);',
      [(parseInt(idSalvAfectAct) === 0) ? req.params.id_salvAfectAct : idSalvAfectAct]
    )
    return Array.isArray(results) ? results : []
  }
}
