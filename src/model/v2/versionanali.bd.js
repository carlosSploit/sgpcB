const Dbcone = require('../../../config/bd/connet_mysql')
const conexibd = new Dbcone()
// ######################### DbclientAnali ###################################
module.exports = class Dbversionanali {
  async inser_versionanali (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `insert_versionanali`(?);',
      [
        req.body.id_proceso
      ],
      'Se inserto correctamente la version de analisis de un proceso'
    )
    return results
  }

  // async eliminar_versionanali (req, res) {
  //   const results = await conexibd.single_query(
  //     req,
  //     res,
  //     'CALL `delete_versionanali`( ? );',
  //     [
  //       req.params.id_versionAnali
  //     ],
  //     'Se elimino correctamente la version de analisis de un proceso'
  //   )
  //   return results
  // }

  async list_versionanali (req, res, idProceso = 0) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `list_versionanali`(?);',
      [(parseInt(idProceso) === 0) ? req.params.id_proceso : idProceso]
    )
    return Array.isArray(results) ? results : []
  }
}
