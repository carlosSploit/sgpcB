const Dbcone = require('../../../config/bd/connet_mysql')
const conexibd = new Dbcone()
const ETLescalRiesgo = require('../../ETL/escalRiesgo.etl')
const objescalRiesgo = new ETLescalRiesgo()
// ######################### DbclientAnali ###################################
module.exports = class Dbescalaimpacto {
  async inser_escalRiesgo (req, res) {
    // trubcar la tabla antes de insertar los datos
    await conexibd.single_query(
      req,
      res,
      'TRUNCATE TABLE escalariesgo;',
      [],
      'Se trunco o limpio correctamente las escalas de degradacion'
    )
    const migrarDat = await conexibd.single_query(
      req,
      res,
      await objescalRiesgo.formatMYSQL('INSERT INTO `escalariesgo`(`id_escalRiesgo`, `nombreEscalRiesgo`, `abreb`, `valor`, `rangeValid`, `estade`) VALUES '),
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

  async list_escalRiesgo (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `list_escalariesgo`();',
      []
    )
    return Array.isArray(results) ? results : []
  }
}
