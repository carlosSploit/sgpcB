const Dbcone = require('../../../config/bd/connet_mysql')
const conexibd = new Dbcone()
const ETLclasscontroles = require('../../ETL/classcontroles.etl')
const objclasscontroles = new ETLclasscontroles()
// ######################### DbclientAnali ###################################
module.exports = class Dbclasscontrol {
  async inser_classcontrol (req, res) {
    // trubcar la tabla antes de insertar los datos
    await conexibd.single_query(
      req,
      res,
      'TRUNCATE TABLE classcontrol;',
      [],
      'Se trunco o limpio correctamente las clases de control'
    )
    const migrarDat = await conexibd.single_query(
      req,
      res,
      await objclasscontroles.formatMYSQL('INSERT INTO `classcontrol`(`id_classControl`, `abrebClassControl`, `nombreClassControl`, `estade`) VALUES '),
      [],
      'Se migro correctamente las clases de control'
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

  async list_classcontrol (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `list_classcontrol`();',
      []
    )
    return Array.isArray(results) ? results : []
  }
}
