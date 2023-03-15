const Dbcone = require('../../../config/bd/connet_mysql')
const conexibd = new Dbcone()
const ETLafectaTip = require('../../ETL/afectaTip.etl')
const objEtlafectaTip = new ETLafectaTip()
// ######################### DbclientAnali ###################################
module.exports = class DbtipoActiv {
  async inser_afectatip (req, res) {
    // trubcar la tabla antes de insertar los datos
    await conexibd.single_query(
      req,
      res,
      'TRUNCATE TABLE afectatip;',
      [],
      'Se trunco o limpio correctamente los tipos de activos afeactados por la amenaza'
    )
    const migrarDat = await conexibd.single_query(
      req,
      res,
      await objEtlafectaTip.formatMYSQL('INSERT INTO `afectatip`(`id_adectTip`, `id_amenazas`, `id_libreryAmen`, `id_tipoActivo`, `estade`) VALUES '),
      [],
      'Se migro correctamente los tipos de activos afeactados por la amenaza'
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

  async list_afectaTip (req, res, idLibreryAmen = 0) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `list_afectaTip`(?);',
      [(parseInt(idLibreryAmen) === 0) ? req.params.id_libreryAmen : idLibreryAmen]
    )
    return Array.isArray(results) ? results : []
  }
}
