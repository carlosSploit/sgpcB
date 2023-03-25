const Dbcone = require('../../../config/bd/connet_mysql')
const conexibd = new Dbcone()
const ETLescalImpacResid = require('../../ETL/escalImpacResid.etl')
const objescalImpacResid = new ETLescalImpacResid()
// ######################### DbclientAnali ###################################
module.exports = class Dbescalafrecuenresidual {
  async inser_escalafrecuenresidual (req, res) {
    // trubcar la tabla antes de insertar los datos
    await conexibd.single_query(
      req,
      res,
      'TRUNCATE TABLE escalafrecuenresidual;',
      [],
      'Se trunco o limpio correctamente las escalas del frecuencia residual'
    )
    const migrarDat = await conexibd.single_query(
      req,
      res,
      await objescalImpacResid.formatMYSQL('INSERT INTO `escalafrecuenresidual`(`id_escalFrecuenResid`, `nombreEscalFrecuenResid`, `codigEscalFrecuenResid`, `valorEscalFrecuenResid`, `rangValEscalFrecuenResid`, `estade`) VALUES '),
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

  async liest_escalafrecuenresidual (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `liest_escalafrecuenresidual`();',
      []
    )
    return Array.isArray(results) ? results : []
  }
}
