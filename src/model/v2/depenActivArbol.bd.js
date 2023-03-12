const Dbcone = require('../../../config/bd/connet_mysql')
const conexibd = new Dbcone()
const ETLdependetAct = require('../../ETL/dependetAct.etl')
const objEtldependetAct = new ETLdependetAct()
// ######################### DbclientAnali ###################################
module.exports = class DbdepenActivArbol {
  async inser_DbdepenActivArbol (req, res) {
    // trubcar la tabla antes de insertar los datos
    await conexibd.single_query(
      req,
      res,
      'TRUNCATE TABLE dependactivarbol;',
      [],
      'Se migro correctamente los tipos de activos'
    )
    const migrarDat = await conexibd.single_query(
      req,
      res,
      await objEtldependetAct.formatMYSQL('INSERT INTO `dependactivarbol`(`id_dependActivArbol`, `id_tipoActivo`, `id_ActiviDepent`, `estade`, `fechaEnlace`) VALUES'),
      [],
      'Se migro correctamente los dependencia Activ'
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

  async list_DbdepenActivArbol (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `list_depentactivarbol`();',
      []
    )
    return Array.isArray(results) ? results : []
  }
}
