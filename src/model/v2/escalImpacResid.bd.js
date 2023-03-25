const Dbcone = require('../../../config/bd/connet_mysql')
const conexibd = new Dbcone()
const ETLescalImpacResid = require('../../ETL/escalImpacResid.etl')
const objescalImpacResid = new ETLescalImpacResid()
// ######################### DbclientAnali ###################################
module.exports = class Dbescalaimpactoresidual {
  async inser_escalaimpactoresidual (req, res) {
    // trubcar la tabla antes de insertar los datos
    await conexibd.single_query(
      req,
      res,
      'TRUNCATE TABLE escalaimpactoresidual;',
      [],
      'Se trunco o limpio correctamente las escalas del impacto residual'
    )
    const migrarDat = await conexibd.single_query(
      req,
      res,
      await objescalImpacResid.formatMYSQL('INSERT INTO `escalaimpactoresidual`(`id_escalImpaResid`, `nombreEscalImpaResid`, `codigEscalImpaResid`, `valorEscalImpaResid`, `rangValEscalImpaResid`, `estade`) VALUES '),
      [],
      'Se migro correctamente las escalas del impacto residual'
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

  async liest_escalaimpactoresidual (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `liest_escalaimpactoresidual`();',
      []
    )
    return Array.isArray(results) ? results : []
  }
}
