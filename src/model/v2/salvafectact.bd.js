const Dbcone = require('../../../config/bd/connet_mysql')
const conexibd = new Dbcone()
// ######################### DbclientAnali ###################################
module.exports = class DbsalvAfectAct {
  async insert_salvAfectAct (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `insert_salvAfectAct`(?,?,?,?);',
      [
        req.body.id_afectaActiv,
        req.body.id_control,
        req.body.id_salvaguarda,
        req.body.extrategia
      ],
      'Se enlazo correctamente la salvaguarda a la amenaza'
    )
    return results
  }

  async actualizo_salvAfectAct (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `update_salvAfectAct`(?,?,?);',
      [
        req.params.id_salvAfectAct,
        req.body.id_control,
        req.body.extrategia
      ],
      'Se actualizo correctamente la salvaguarda a la amenaza'
    )
    return results
  }

  async eliminar_salvAfectAct (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `delete_salvAfectAct`( ? );',
      [
        req.params.id_salvAfectAct
      ],
      'Se elimino correctamente la salvaguarda a la amenaza'
    )
    return results
  }

  async list_salvAfectAct (req, res, idAfectaActiv = 0) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `list_salvAfectAct`(?);',
      [(parseInt(idAfectaActiv) === 0) ? req.params.id_afectaActiv : idAfectaActiv]
    )
    return Array.isArray(results) ? results : []
  }
}
