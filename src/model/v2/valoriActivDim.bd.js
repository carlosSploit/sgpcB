const Dbcone = require('../../../config/bd/connet_mysql')
const conexibd = new Dbcone()
// ######################### DbclientAnali ###################################
module.exports = class DbvaloriActivDimen {
  async inser_valoriActivDimen (req, res, isObjJson = false, ObjJson = {
    id_valorActiv: 0,
    id_dimension: 0,
    valorAcivCualit: 0,
    id_varlotActivCualit: 0,
    tipValoActivDimen: 'N'
  }) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `insert_valoriActivDimen`(?,?,?,?,?,?);',
      // eslint-disable-next-line multiline-ternary
      (isObjJson) ? [
        ObjJson.id_valorActiv,
        ObjJson.id_dimension,
        ObjJson.valorAcivCualit,
        ObjJson.id_varlotActivCualit,
        ObjJson.tipValoActivDimen,
        ObjJson.id_nivelCritec
      ] : [
        req.body.id_valorActiv,
        req.body.id_dimension,
        req.body.valorAcivCualit,
        req.body.id_varlotActivCualit,
        req.body.tipValoActivDimen,
        req.body.id_nivelCritec
      ],
      'Se inserto correctamente la empresa'
    )
    return results
  }

  // async actualizar_valoractiv (req, res) {
  //   const results = await conexibd.single_query(
  //     req,
  //     res,
  //     'CALL `update_valoractiv`(?,?,?,?,?,?,?,?);',
  //     [
  //       req.params.id_valorActiv,
  //       req.body.valorActivCuanti
  //     ],
  //     'Se actualizo correctamente el empresa'
  //   )
  //   return results
  // }

  // async loadProm_valoractiv (req, res, idValorActiv = 0) {
  //   const results = await conexibd.single_query(
  //     req,
  //     res,
  //     'CALL `loadProm_valoractiv`( ? );',
  //     [idValorActiv],
  //     'Se actualizo correctamente el empresa'
  //   )
  //   return results
  // }

  async eliminar_valoriActivDimen (req, res, idValorActiDimen = 0) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `delete_valoriActivDimen`( ? );',
      [
        (idValorActiDimen === 0) ? req.params.id_valorActiDimen : idValorActiDimen
      ],
      'Se elimino correctamente el empresa'
    )
    return results
  }

  async list_valoriActivDimen (req, res, idValorActiv = 0) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `list_valoriActivDimen`(?);',
      [(parseInt(idValorActiv) === 0) ? req.params.id_valorActiv : idValorActiv]
    )
    return Array.isArray(results) ? results : []
  }

  // async list_empresa (req, res) {
  //   const results = await conexibd.single_query(
  //     req,
  //     res,
  //     'CALL `list_empresa`(?);',
  //     [req.params.id_clienAnalit]
  //   )
  //   return Array.isArray(results) ? results : []
  // }
}
