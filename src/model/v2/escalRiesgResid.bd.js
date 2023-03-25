const Dbcone = require('../../../config/bd/connet_mysql')
const conexibd = new Dbcone()
const ETLescalRiesgResid = require('../../ETL/escalRiesgResid.etl')
const objescalRiesgResid = new ETLescalRiesgResid()
// ######################### DbclientAnali ###################################
module.exports = class Dbescalariesgoresidual {
  async inser_escalariesgoresidual (req, res) {
    // trubcar la tabla antes de insertar los datos
    await conexibd.single_query(
      req,
      res,
      'TRUNCATE TABLE escalariesgoresidual;',
      [],
      'Se trunco o limpio correctamente las escalas del impacto residual'
    )
    const migrarDat = await conexibd.single_query(
      req,
      res,
      await objescalRiesgResid.formatMYSQL('INSERT INTO `escalariesgoresidual`(`id_escalRiesgResid`, `nombreEscalRiesgResid`, `codigEscalRiesgResid`, `valorEscalRiesgResid`, `rangValEscalRiesgResid`, `estade`) VALUES '),
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

  async liest_escalariesgoresidual (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `liest_escalariesgoresidual`();',
      []
    )
    return Array.isArray(results) ? results : []
  }
}
