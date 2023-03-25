const Dbcone = require('../../../config/bd/connet_mysql')
const conexibd = new Dbcone()
const ETLcontroles = require('../../ETL/controles.etl')
const objcontroles = new ETLcontroles()
// ######################### DbclientAnali ###################################
module.exports = class Dbcontroles {
  async inser_controles (req, res) {
    // trubcar la tabla antes de insertar los datos
    await conexibd.single_query(
      req,
      res,
      'TRUNCATE TABLE controles;',
      [],
      'Se trunco o limpio correctamente los tipos de salvaguardas'
    )
    const migrarDat = await conexibd.single_query(
      req,
      res,
      await objcontroles.formatMYSQL('INSERT INTO `controles`(`id_control`, `id_classControl`, `codigo`, `codeDepende`, `DescripccionControl`, `tipoControl`, `id_depencontrol`, `estade`) VALUES '),
      [],
      'Se migro correctamente los tipos de salvaguardas'
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

  async list_controles (req, res, idClassControl = -1) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `list_controles`(?);',
      [(parseInt(idClassControl) === -1) ? req.params.id_classControl : idClassControl]
    )
    return Array.isArray(results) ? results : []
  }
}
