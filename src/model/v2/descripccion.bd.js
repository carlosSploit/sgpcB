const Dbcone = require('../../../config/bd/connet_mysql')
const conexibd = new Dbcone()
const ETLdimensiones = require('../../ETL/dimensiones.etl')
const objEtldimensiones = new ETLdimensiones()
// ######################### DbclientAnali ###################################
module.exports = class DbtipoActiv {
  async inser_dimensionanalisis (req, res) {
    // trubcar la tabla antes de insertar los datos
    await conexibd.single_query(
      req,
      res,
      'TRUNCATE TABLE dimensionanalisis;',
      [],
      'Se migro correctamente los tipos de activos'
    )
    const consult = await objEtldimensiones.formatMYSQL('INSERT INTO `dimensionanalisis`(`id_dimension`, `nombreDimens`, `abreb`, `descripc`, `preguAnalis`, `estade`) VALUES ')
    console.log(consult)
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

  async list_dimensionanalisis (req, res, codeabre = 0) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `list_dimensionanalisis`();',
      []
    )
    return Array.isArray(results) ? results : []
  }
}
