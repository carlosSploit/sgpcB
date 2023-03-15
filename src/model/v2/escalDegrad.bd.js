const Dbcone = require('../../../config/bd/connet_mysql')
const conexibd = new Dbcone()
const ETLescalDegrad = require('../../ETL/escalDegrad.etl')
const objescalDegrad = new ETLescalDegrad()
// ######################### DbclientAnali ###################################
module.exports = class DbescalDegrad {
  async inser_escalDegrad (req, res) {
    // trubcar la tabla antes de insertar los datos
    await conexibd.single_query(
      req,
      res,
      'TRUNCATE TABLE escaladegrad;',
      [],
      'Se trunco o limpio correctamente las escalas de degradacion'
    )
    const migrarDat = await conexibd.single_query(
      req,
      res,
      await objescalDegrad.formatMYSQL('INSERT INTO `escaladegrad`(`id_escalDegrad`, `nombreEscalDreg`, `abreb`, `rangeValid`, `estade`) VALUES '),
      [],
      'Se migro correctamente las escalas de degradacion'
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

  async list_escaladegrad (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `list_escaladegrad`();',
      []
    )
    return Array.isArray(results) ? results : []
  }
}
