const Dbcone = require('../../../config/bd/connet_mysql')
const conexibd = new Dbcone()
const ETLescalDegradResid = require('../../ETL/escalDegradResid.etl')
const objescalDegradResid = new ETLescalDegradResid()
// ######################### DbclientAnali ###################################
module.exports = class Dbescaladegradresidual {
  async inser_escaladegradresidual (req, res) {
    // trubcar la tabla antes de insertar los datos
    await conexibd.single_query(
      req,
      res,
      'TRUNCATE TABLE escaladegradresidual;',
      [],
      'Se trunco o limpio correctamente las escalas del degradacion residual'
    )
    const migrarDat = await conexibd.single_query(
      req,
      res,
      await objescalDegradResid.formatMYSQL('INSERT INTO `escaladegradresidual`(`id_escalDegradResid`, `nombreEscalDegradResid`, `codigEscalDegradResid`, `valorEscalDegradResid`, `rangValEscalDegradResid`, `estade`) VALUES '),
      [],
      'Se migro correctamente las escalas del frecuencia residual'
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

  async liest_escaladegradresidual (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `liest_escaladegradresidual`();',
      []
    )
    return Array.isArray(results) ? results : []
  }
}
