const Dbcone = require('../../../config/bd/connet_mysql')
const conexibd = new Dbcone()
const ETLsalvaguardas = require('../../ETL/salvaguardas.etl')
const objEtlsalvaguardas = new ETLsalvaguardas()
// ######################### DbclientAnali ###################################
module.exports = class Dbsalvaguardas {
  async inser_salvaguardas (req, res) {
    // trubcar la tabla antes de insertar los datos
    await conexibd.single_query(
      req,
      res,
      'TRUNCATE TABLE salvaguardas;',
      [],
      'Se trunco o limpio correctamente los tipos de salvaguardas'
    )
    const migrarDat = await conexibd.single_query(
      req,
      res,
      await objEtlsalvaguardas.formatMYSQL('INSERT INTO `salvaguardas`(`id_salvaguardas`, `id_tipoSalva`, `abreb`, `descripc`, `estade`) VALUES '),
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

  async list_salvaguardas (req, res, idTipoSalvg = -1) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `list_salvaguardas`(?);',
      [(parseInt(idTipoSalvg) === -1) ? req.params.id_tipoSalvg : idTipoSalvg]
    )
    return Array.isArray(results) ? results : []
  }
}
