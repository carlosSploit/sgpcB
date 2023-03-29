const Validator = require('../../../config/complementos/validator')
const objvalit = new Validator()
const Bdafectaactiv = require('../../negocio/v2/afectaactiv.negocio')
const objafectaactiv = new Bdafectaactiv()
const Bdsalvafectact = require('../../model/v2/salvafectact.bd')
const objsalvafectact = new Bdsalvafectact()
const BdvaloriAmenasDim = require('./valoriAmenasDim.negocio')
const objvaloriAmenasDim = new BdvaloriAmenasDim()
const BdescalRiesgo = require('../../model/v2/escalRiesgo.bd')
const objescalRiesgo = new BdescalRiesgo()
const BdescalImpacResid = require('../../model/v2/escalImpacResid.bd')
const objescalImpacResid = new BdescalImpacResid()

const Valideinsert = (req) => {
  const valida =
    objvalit.validator_vacio(req.body.extrategia)

  const dataarray = [
    {
      datacom: 'extrategia',
      valide: objvalit.validator_vacio(req.body.extrategia)
    }
  ]

  const auxvalidetdata = dataarray.filter((item) => {
    return item.valide
  })
  console.log(auxvalidetdata)
  return { valida, auxvalidetdata }
}

const valideInsertSalvaguard = async (req, res) => {
  try {
    const idAfetActiv = req.body.id_afectaActiv
    const idSalvaguarda = req.body.id_salvaguarda
    const resultCom = await objsalvafectact.list_salvAfectAct(req, res, idAfetActiv)
    const filterData = resultCom.filter((item) => {
      return parseInt(item.id_salvaguarda) === parseInt(idSalvaguarda)
    })
    return filterData.length > 0
  } catch (error) {
    return true
  }
}

module.exports = class ngsalvAfectAct {
  async insert_salvAfectAct (req, res) {
    // validar datos insertados
    const validado = Valideinsert(req)

    if (validado.valida) {
      res.send({
        status: 404,
        typo: 'error',
        messege: 'Casillas mal ingresadas.',
        data: validado.auxvalidetdata
      })
      // eslint-disable-next-line no-useless-return
      return
    }

    if (parseInt(req.body.id_salvaguarda) === 0) {
      res.send({
        status: 404,
        typo: 'error',
        messege: 'Erro, porfavor enlazar una salvaguarda.',
        data: ''
      })
    }

    // validar datos insertados
    const validSalvaguar = await valideInsertSalvaguard(req, res)

    if (validSalvaguar) {
      res.send({
        status: 404,
        typo: 'error',
        messege: 'Esta salvaguarda ya fue enlazaba.',
        data: validado.auxvalidetdata
      })
      // eslint-disable-next-line no-useless-return
      return
    }

    const result = await objsalvafectact.insert_salvAfectAct(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }

  async actualizo_salvAfectAct (req, res) {
    // validar datos insertados
    const validado = Valideinsert(req)

    if (validado.valida) {
      res.send({
        status: 404,
        typo: 'error',
        messege: 'Casillas mal ingresadas',
        data: validado.auxvalidetdata
      })
      // eslint-disable-next-line no-useless-return
      return
    }

    // si todo esta correcto, inserta los datos
    const result = await objsalvafectact.actualizo_salvAfectAct(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }

  extraer_key_impactResidul (listScale, valueImpactoResi) {
    const rangeValori = listScale
    const itemvalor = rangeValori.filter((item) => {
      const filterRange = item.rangValEscalImpaResid.split(' - ').map((item) => { return parseFloat(parseFloat(item).toFixed(1)) })
      return (filterRange[0] <= valueImpactoResi) && (valueImpactoResi <= filterRange[1])
    })
    return itemvalor[0]
  }

  async list_salvAfectAct (req, res) {
    const result = await objsalvafectact.list_salvAfectAct(req, res)
    const listkeyRiesgo = await objescalRiesgo.list_escalRiesgo(req, res)
    const listkeyImpactResi = await objescalImpacResid.liest_escalaimpactoresidual(req, res)
    req.params.id_activProsVerAnali = 0
    const listResulAnali = await objafectaactiv.list_afectaactiv(req, res)
    if (parseInt(listResulAnali.length) === 0) return result
    // realizar los nuevos calculos esperados
    const listAux = result.map((item) => {
      const objJson = { ...item }
      // eslint-disable-next-line eqeqeq
      if (((objJson.id_escalEficDegr == 0) || (objJson.id_escalEficDegr == null)) && ((objJson.id_escalEficFrec == 0) || (objJson.id_escalEficFrec == null))) return objJson
      // informacion de la valorizacion de la amenaza
      const listDataAmenas = listResulAnali.filter((item) => {
        return parseInt(item.id_afectaActiv) === parseInt(objJson.id_afectaActiv)
      })
      if (parseInt(listDataAmenas.length) === 0) return objJson
      const ObjDataAmenas = listDataAmenas[0]
      // ----------------------------------------------------------------------- CALCULO IMPACTO RESIDUAL
      const objRiesgo = objvaloriAmenasDim.extraer_key_riesgo(listkeyRiesgo, ObjDataAmenas.valRiesgoCualit)
      const NormaliceDegradResid = (Math.round(objJson.valDegraResidCuali * 10) * 10) / 100
      const valEscalImpResid = parseFloat(((objRiesgo.valor) * (NormaliceDegradResid)).toFixed(2))
      objJson.valImpactResidCuali = valEscalImpResid
      // console.log('Degradacion Residul:', NormaliceDegradResid)
      // console.log('Riesgo:', objRiesgo.valor)
      // console.log('Impacto Residual:', valEscalImpResid)
      // ----------------------------------------------------------------------- CALCULO RIESGO RESIDUAL
      const valutImapResit = this.extraer_key_impactResidul(listkeyImpactResi, valEscalImpResid)
      const valEscalRiesgResid = ((Math.round(objJson.valEscalFrecuenResidCuali)) * (valutImapResit.valorEscalImpaResid))
      objJson.valRiesgResidCuali = valEscalRiesgResid
      // console.log('Impact Residul:', valutImapResit.valorEscalImpaResid)
      // console.log('Frecuencia Resid:', Math.round(objJson.valEscalFrecuenResidCuali))
      // console.log('Rieesgo Residual:', valEscalRiesgResid)
      return objJson
    })
    // console.log(listAux)
    res.json(listAux)
  }

  async delete_salvAfectAct (req, res) {
    const result = await objsalvafectact.eliminar_salvAfectAct(req, res)
    res.json(result)
  }
}
