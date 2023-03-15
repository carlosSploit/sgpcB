const Dbcone = require('../../../config/bd/connet_mysql')
const conexibd = new Dbcone()
const ETLamenasas = require('../../ETL/amenasas.etl')
const objEtlamenasas = new ETLamenasas()
// ######################### DbclientAnali ###################################
module.exports = class DbtipoActiv {
  async inser_amenazas (req, res) {
    // trubcar la tabla antes de insertar los datos
    await conexibd.single_query(
      req,
      res,
      'TRUNCATE TABLE amenazas;',
      [],
      'Se trunco o limpio correctamente las amenazas'
    )
    const migrarDat = await conexibd.single_query(
      req,
      res,
      await objEtlamenasas.formatMYSQL('INSERT INTO `amenazas`(`id_amenaza`, `nombreAmena`, `abreb`, `descripc`, `id_tipoActiv`, `estade`) VALUES '),
      [],
      'Se migro correctamente las amenazas'
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

  async list_amenas (req, res, idTipoActiv = -1) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `list_amenas`(?);',
      [(parseInt(idTipoActiv) === -1) ? req.params.id_tipoActiv : idTipoActiv]
    )
    return Array.isArray(results) ? results : []
  }
}
