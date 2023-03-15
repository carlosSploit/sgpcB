const Dbcone = require('../../../config/bd/connet_mysql')
const conexibd = new Dbcone()
const ETLtipoAmens = require('../../ETL/tipoAmens.etl')
const objEtlTipoAmens = new ETLtipoAmens()
// ######################### DbclientAnali ###################################
module.exports = class DbtipoActiv {
  async inser_tipoamen (req, res) {
    // trubcar la tabla antes de insertar los datos
    await conexibd.single_query(
      req,
      res,
      'TRUNCATE TABLE tipoamen;',
      [],
      'Se migro correctamente los tipos de amenazas'
    )
    const migrarDat = await conexibd.single_query(
      req,
      res,
      await objEtlTipoAmens.formatMYSQL('INSERT INTO `tipoamen`(`id_tipoActiv`, `nombreTipoActiv`, `abreb`, `descripc`, `estade`) VALUES '),
      [],
      'Se migro correctamente los tipos de amenazas'
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

  async list_tipoAmenasa (req, res, codeabre = 0) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `list_tipoAmenasa`();',
      []
    )
    return Array.isArray(results) ? results : []
  }
}
