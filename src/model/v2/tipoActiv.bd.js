const Dbcone = require('../../../config/bd/connet_mysql')
const conexibd = new Dbcone()
const ETLtipoActivo = require('../../ETL/tipoActiv.etl')
const objEtlTipoActivo = new ETLtipoActivo()
// ######################### DbclientAnali ###################################
module.exports = class DbtipoActiv {
  async inser_tipoActiv (req, res) {
    // trubcar la tabla antes de insertar los datos
    await conexibd.single_query(
      req,
      res,
      'TRUNCATE TABLE tipoactivo;',
      [],
      'Se migro correctamente los tipos de activos'
    )
    const migrarDat = await conexibd.single_query(
      req,
      res,
      await objEtlTipoActivo.formatMYSQL('INSERT INTO `tipoactivo`(`id_tipoActivo`, `nombreTipoActivo`, `abrebiat`, `dependAbreb`, `isDependeTipoPad`, `id_dependeTipoPad`, `estade`) VALUES', 40),
      [],
      'Se migro correctamente los tipos de activos'
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

  async list_tipoActiv (req, res, codeabre = 0) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `list_tipoActiv`(?);',
      [(parseInt(codeabre) === 0) ? req.params.id_tipoActiv : codeabre]
    )
    return Array.isArray(results) ? results : []
  }
}
