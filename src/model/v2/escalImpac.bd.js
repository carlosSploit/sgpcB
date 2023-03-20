const Dbcone = require('../../../config/bd/connet_mysql')
const conexibd = new Dbcone()
const ETLescalImpac = require('../../ETL/escalImpac.etl')
const objescalImpac = new ETLescalImpac()
// ######################### DbclientAnali ###################################
module.exports = class Dbescalaimpacto {
  async inser_escalaimpacto (req, res) {
    // trubcar la tabla antes de insertar los datos
    await conexibd.single_query(
      req,
      res,
      'TRUNCATE TABLE escalaimpacto;',
      [],
      'Se trunco o limpio correctamente las escalas de degradacion'
    )
    const migrarDat = await conexibd.single_query(
      req,
      res,
      await objescalImpac.formatMYSQL('INSERT INTO `escalaimpacto`(`id_escaleImpac`, `nombreEscalImpac`, `abreb`, `valor`, `rangeValid`, `estade`) VALUES '),
      [],
      'Se migro correctamente las escalas de impacto'
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

  async list_escalaimpacto (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `list_escalaimpacto`();',
      []
    )
    return Array.isArray(results) ? results : []
  }
}
