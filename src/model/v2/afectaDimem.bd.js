const Dbcone = require('../../../config/bd/connet_mysql')
const conexibd = new Dbcone()
const ETLafectaDimen = require('../../ETL/afectaDimen.etl')
const objafectaDimen = new ETLafectaDimen()
// ######################### DbclientAnali ###################################
module.exports = class DbafectaDimem {
  async inser_afectaDimem (req, res) {
    // trubcar la tabla antes de insertar los datos
    await conexibd.single_query(
      req,
      res,
      'TRUNCATE TABLE afectatip;',
      [],
      'Se trunco o limpio correctamente las dimensiones afeactadas por la amenaza'
    )
    const migrarDat = await conexibd.single_query(
      req,
      res,
      await objafectaDimen.formatMYSQL('INSERT INTO `afectadimen`(`id_afectDimen`, `id_dimension`, `id_amenaza`, `estade`) VALUES '),
      [],
      'Se migro correctamente las dimensiones afeactadas por la amenaza'
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

  async list_afectaDimem (req, res) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `list_afectaDimem`();',
      []
    )
    return Array.isArray(results) ? results : []
  }
}
