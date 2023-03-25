const Dbcone = require('../../../config/bd/connet_mysql')
const conexibd = new Dbcone()
// ######################### DbvalorEficacia ###################################
module.exports = class DbvalorEficacia {
  async actualise_valorEficacia (req, res, isObjData = false, objData = {
    id_salvAfectAct: 0,
    id_escalEficDegr: 0,
    valEficDegr: 0,
    id_escalEficFrec: 0,
    valEficFrec: 0,
    id_escalEficImpac: 0,
    valEficImpac: 0
  }) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `update_valorEficacia`(?,?,?,?,?,?,?);',
      // eslint-disable-next-line space-infix-ops, multiline-ternary
      (isObjData)?[
        objData.id_salvAfectAct,
        objData.id_escalEficDegr,
        objData.valEficDegr,
        objData.id_escalEficFrec,
        objData.valEficFrec,
        objData.id_escalEficImpac,
        objData.valEficImpac
      // eslint-disable-next-line space-infix-ops
      ]:[
        req.params.id_salvAfectAct,
        req.body.id_escalEficDegr,
        req.body.valEficDegr,
        req.body.id_escalEficFrec,
        req.body.valEficFrec,
        req.body.id_escalEficImpac,
        req.body.valEficImpac
      ],
      'Se actualizo correctamente la valorizacion de la salvaguarda'
    )
    return results
  }

  async actualise_valorEficaciaDim (req, res, objData = {
    id_valorEficacia: 0,
    id_dimension: 0,
    id_escalDegradResid: 0,
    valEscalDegradResid: 0,
    id_escalFrecuenResid: 0,
    valEscalFrecuenResid: 0,
    id_escalImpaResid: 0,
    valEscalImpaResid: 0,
    id_escalRiesgResid: 0,
    valEscalRiesgResid: 0
  }) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `update_valoreficacidimension`(?,?,?,?,?,?,?,?,?,?);',
      // eslint-disable-next-line space-infix-ops, multiline-ternary
      [
        objData.id_valorEficacia,
        objData.id_dimension,
        objData.id_escalDegradResid,
        objData.valEscalDegradResid,
        objData.id_escalFrecuenResid,
        objData.valEscalFrecuenResid,
        objData.id_escalImpaResid,
        objData.valEscalImpaResid,
        objData.id_escalRiesgResid,
        objData.valEscalRiesgResid
      // eslint-disable-next-line space-infix-ops
      ],
      'Se actualizo correctamente la valorizacion de la eficacia por cada version'
    )
    return results
  }

  async read_valoreficacia (req, res, idSalvAfectAct = 0) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `read_valoreficacia`(?);',
      [(parseInt(idSalvAfectAct) === 0) ? req.params.id_salvAfectAct : idSalvAfectAct]
    )
    return Array.isArray(results) ? results : []
  }

  async loadProm_valoreficacia (req, res, idValorEficacia = 0) {
    const results = await conexibd.single_query(
      req,
      res,
      'CALL `loadProm_valoraSalv`( ? );',
      [idValorEficacia],
      'Se cargo la valorizacion correctamente la en la base de datos'
    )
    return results
  }
}
