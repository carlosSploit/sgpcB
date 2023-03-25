const Dbcone = require('../../../config/bd/connet_mysql')
const conexibd = new Dbcone()
const ETLescalEficacia = require('../../ETL/escalEficacia.etl')
const objETLescalEficacia = new ETLescalEficacia()
// ######################### DbclientAnali ###################################
module.exports = class Dbescalaefica {
  async inser_escalaefica (req, res) {
    // trubcar la tabla antes de insertar los datos
    await conexibd.single_query(
      req,
      res,
      'TRUNCATE TABLE escalaefica;',
      [],
      'Se trunco o limpio correctamente las escalas de eficacia'
    )
    const migrarDat = await conexibd.single_query(
      req,
      res,
      await objETLescalEficacia.formatMYSQL('INSERT INTO `escalaefica`(`id_escalEfic`, `nombreEscalEfic`, `codigEscalEfic`, `valorEscalEfic`, `rangValEscalEfic`, `estade`) VALUES '),
      [],
      'Se migro correctamente las escalas de eficacia'
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

  async list_escalEficacia (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `list_escalEficacia`();',
      []
    )
    return Array.isArray(results) ? results : []
  }
}
