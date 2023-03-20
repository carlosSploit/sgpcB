const Dbcone = require('../../../config/bd/connet_mysql')
const conexibd = new Dbcone()
const ETLescalFrecuen = require('../../ETL/escalFrecuen.etl')
const objescalFrecuen = new ETLescalFrecuen()
// ######################### DbclientAnali ###################################
module.exports = class Dbescalafrecuencia {
  async inser_escalFrecuen (req, res) {
    // trubcar la tabla antes de insertar los datos
    await conexibd.single_query(
      req,
      res,
      'TRUNCATE TABLE escalafrecuencia;',
      [],
      'Se trunco o limpio correctamente las escalas de frecuencia'
    )
    const migrarDat = await conexibd.single_query(
      req,
      res,
      await objescalFrecuen.formatMYSQL('INSERT INTO `escalafrecuencia`(`id_escalaFrecuenc`, `nombreEscalFrecuenc`, `abreb`, `valFrecuncia`, `descripc`, `estade`, `valueCuali`) VALUES '),
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

  async list_escalafrecuencia (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `list_escalafrecuencia`();',
      []
    )
    return Array.isArray(results) ? results : []
  }
}
