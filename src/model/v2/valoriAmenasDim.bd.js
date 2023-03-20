const Dbcone = require('../../../config/bd/connet_mysql')
const conexibd = new Dbcone()
// ######################### DbclientAnali ###################################
module.exports = class DbvalorAfectAmenDim {
  async loadProm_valorAfectAmenDim (req, res, isObjJson = false, ObjJson = {
    id_valAfectAmenDimen: 0,
    id_escaleImpac: 0,
    valorImpacto: 0,
    id_escalRiesgo: 0,
    valNivelRiesgo: 0
  }) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `loadProm_valorAfectAmenDim`(?,?,?,?,?);',
      // eslint-disable-next-line multiline-ternary
      (isObjJson) ? [
        ObjJson.id_valAfectAmenDimen,
        ObjJson.id_escaleImpac,
        ObjJson.valorImpacto,
        ObjJson.id_escalRiesgo,
        ObjJson.valNivelRiesgo
      ] : [
        req.body.id_valAfectAmenDimen,
        req.body.id_escaleImpac,
        req.body.valorImpacto,
        req.body.id_escalRiesgo,
        req.body.valNivelRiesgo
      ],
      'Se cargo correctamente la valorizacion del riesgo de forma cualitativa'
    )
    return results
  }

  async insert_valorAfectAmenDim (req, res, isObjJson = false, ObjJson = {
    id_valorAfectAmen: 0,
    id_dimension: 0,
    id_escalDegrad: 0,
    valorDegrad: 90
  }) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `insert_valorAfectAmenDim`(?,?,?,?);',
      // eslint-disable-next-line multiline-ternary
      (isObjJson) ? [
        ObjJson.id_valorAfectAmen,
        ObjJson.id_dimension,
        ObjJson.id_escalDegrad,
        ObjJson.valorDegrad
      ] : [
        req.body.id_valorAfectAmen,
        req.body.id_dimension,
        req.body.id_escalDegrad,
        req.body.valorDegrad
      ],
      'Se inserto correctamente la valorizacion de la empresa'
    )
    return results
  }

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

  async eliminar_valorafectamenDim (req, res, idValAfectAmenDimen = 0) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `delete_valorafectamenDim`( ? );',
      [
        (idValAfectAmenDimen === 0) ? req.params.id_valAfectAmenDimen : idValAfectAmenDimen
      ],
      'Se elimino correctamente el empresa'
    )
    return results
  }

  async list_valAfectAmenDimen (req, res, idValorAfectAmen = 0) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `list_valAfectAmenDimen`(?);',
      [(parseInt(idValorAfectAmen) === 0) ? req.params.id_valorAfectAmen : idValorAfectAmen]
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
