const Dbcone = require('../../../config/bd/connet_mysql')
const conexibd = new Dbcone()
const ETLcriteriosValori = require('../../ETL/criteriosValori.etl')
const objEtlcriteriosValori = new ETLcriteriosValori()
// ######################### DbclientAnali ###################################
module.exports = class DbcriteriosValori {
  async inser_criteriosValori (req, res) {
    // trubcar la tabla antes de insertar los datos
    await conexibd.single_query(
      req,
      res,
      'TRUNCATE TABLE criteriosvalor;',
      [],
      'Se migro correctamente los tipos de activos'
    )
    const consult = await objEtlcriteriosValori.formatMYSQL('INSERT INTO `criteriosvalor`(`id_criteriosValor`, `id_tipoCriterValor`, `abreb`, `valori`, `descripcCriterio`, `estade`) VALUES ')
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

  async list_criteriosValori (req, res, codeabre = 0) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `list_criteriosValori`();',
      []
    )
    return Array.isArray(results) ? results : []
  }
}
