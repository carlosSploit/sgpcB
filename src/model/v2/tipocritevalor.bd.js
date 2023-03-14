const Dbcone = require('../../../config/bd/connet_mysql')
const conexibd = new Dbcone()
const ETLtipocritevalor = require('../../ETL/tipocritevalor.etl')
const objtipocritevalor = new ETLtipocritevalor()
// ######################### DbclientAnali ###################################
module.exports = class Dbtipocritervalor {
  async inser_tipocritervalor (req, res) {
    // trubcar la tabla antes de insertar los datos
    await conexibd.single_query(
      req,
      res,
      'TRUNCATE TABLE tipocritervalor;',
      [],
      'Se migro correctamente los tipos de activos'
    )
    const consult = await objtipocritevalor.formatMYSQL('INSERT INTO `tipocritervalor`(`id_tipoCriterValor`, `abreb`, `nombreTipCrit`, `estade`) VALUES ')
    const migrarDat = await conexibd.single_query(
      req,
      res,
      consult,
      [],
      'Se migro correctamente los tipos de activos'
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

  async list_tipocritervalor (req, res, codeabre = 0) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `list_tipocritervalor`();',
      []
    )
    return Array.isArray(results) ? results : []
  }
}
