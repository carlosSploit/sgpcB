const Dbcone = require('../../../config/bd/connet_mysql')
const conexibd = new Dbcone()
const ETLtipoSalvaguarda = require('../../ETL/tipoSalvaguarda.etl')
const objEtltipoSalvaguarda = new ETLtipoSalvaguarda()
// ######################### DbclientAnali ###################################
module.exports = class DbtipoActiv {
  async inser_tiposalvaguarda (req, res) {
    // trubcar la tabla antes de insertar los datos
    await conexibd.single_query(
      req,
      res,
      'TRUNCATE TABLE tiposalvaguarda;',
      [],
      'Se migro correctamente los tipos de salvaguardas'
    )
    const migrarDat = await conexibd.single_query(
      req,
      res,
      await objEtltipoSalvaguarda.formatMYSQL('INSERT INTO `tiposalvaguarda`(`id_tipoSalvaguarda`, `nombreTipoSalg`, `estade`) VALUES '),
      [],
      'Se migro correctamente los tipos de salvaguardas'
    )
    return migrarDat
  }

  // async eliminar_areainterproce (req, res) {
  //   const results = await conexibd.single_query(
  //     req,
  //     res,
  //     'CALL `delet_areainterproce`( ? );',
  //     [
  //       req.params.id_areaProce
  //     ],
  //     'Se elimino correctamente el empresa'
  //   )
  //   return results
  // }

  async list_tiposalvaguarda (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `list_tipoSalv`();',
      []
    )
    return Array.isArray(results) ? results : []
  }
}
