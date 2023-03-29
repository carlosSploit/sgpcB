const BdvalorSalvAfectAct = require('../../model/v2/valorSalvAfectAct.bd')
const objvalorSalvAfectAct = new BdvalorSalvAfectAct()
const BdescalEficacia = require('../../model/v2/escalEficacia.bd')
const objescalEficacia = new BdescalEficacia()
const BdvaloriAmenas = require('../../model/v2/valoriAmenas.bd')
const objvaloriAmenas = new BdvaloriAmenas()
const BdvaloriAmenasDim = require('../../model/v2/valoriAmenasDim.bd')
const objvaloriAmenasDim = new BdvaloriAmenasDim()
// escala
const BdescalDegrResid = require('../../model/v2/escalDegrResid.bd')
const objescalDegrResid = new BdescalDegrResid()
const BdescalFrecuResid = require('../../model/v2/escalFrecuResid.bd')
const objescalFrecuResid = new BdescalFrecuResid()
const BdescalImpacResid = require('../../model/v2/escalImpacResid.bd')
const objescalImpacResid = new BdescalImpacResid()
const BdescalRiesgResid = require('../../model/v2/escalRiesgResid.bd')
const objescalRiesgResid = new BdescalRiesgResid()

async function validValoriAmenaz (req, res, idValorEficacia = -1) {
  // leer la valorizacion de la eficacia
  const result = await objvalorSalvAfectAct.read_valoreficacia(req, res, idValorEficacia)
  if (parseInt(result.length) === 0) return false
  const objResul = result[0]
  // informacion de la valorizacion de la amenaza
  const listResulAnali = await objvaloriAmenas.list_valorafectamen(req, res, objResul.id_afectaActiv)
  if (parseInt(listResulAnali.length) === 0) return false
  const objResulAnali = listResulAnali[0]
  // validar si se realizo una valorizacion
  if ((parseInt(objResulAnali.promEscalDregad) === 0) && (parseInt(objResulAnali.id_escalaFrecuen) === 0)) return false
  return true
}

module.exports = class ngclienAnalit {
  async compruebValoriAmenaz (req, res) {
    const result = await validValoriAmenaz(req, res, req.params.id_salvAfectAct)
    return {
      status: (result) ? 200 : 404,
      typo: (result) ? 'succes' : 'error',
      messege: (result) ? 'La valorizacion de la salvaguarda puede ser ingresado.' : 'La valorizacion de la salvaguarda no puede ser insertada',
      data: result
    }
  }

  async actualise_valorEficacia (req, res) {
    // se puede realizar la valorizacion de la salvaguarda
    const resultValorEficas = await this.compruebValoriAmenaz(req, res)
    if (!resultValorEficas.data) {
      res.send(resultValorEficas)
    }
    // si todo esta correcto, inserta los datos
    const objData = {
      id_salvAfectAct: req.params.id_salvAfectAct,
      ...req.body,
      id_escalEficDegr: 0,
      id_escalEficFrec: 0,
      id_escalEficImpac: 0
    }
    const listDegradEscal = await objescalEficacia.list_escalEficacia(req, res)
    // ------------------------------------------------------------------- capturar el Id de data la escala de eficacia de la degradacion
    const filteRageEscal = listDegradEscal.filter((item) => {
      const rangeDate = item.rangValEscalEfic.split(' - ')
      return (parseInt(rangeDate[0]) <= parseInt(objData.valEficDegr)) && (parseInt(objData.valEficDegr) <= parseInt(rangeDate[1]))
    })
    // console.log(filteRageEscal)
    if (filteRageEscal.length === 0) {
      res.send({
        status: 200,
        typo: 'error',
        messege: 'Error, la valorizacion de la degradacion no coicide con ninguno de los rangos esperados.'
      })
      return
    }
    objData.id_escalEficDegr = filteRageEscal[0].id_escalEfic
    // ------------------------------------------------------------------- capturar el Id de data la escala de eficacia de la frecuencia
    const filteRageEscalFrecuen = listDegradEscal.filter((item) => {
      const rangeDate = item.rangValEscalEfic.split(' - ')
      return (parseInt(rangeDate[0]) <= parseInt(objData.valEficFrec)) && (parseInt(objData.valEficFrec) <= parseInt(rangeDate[1]))
    })
    // console.log(filteRageEscalFrecuen)
    if (filteRageEscalFrecuen.length === 0) {
      res.send({
        status: 200,
        typo: 'error',
        messege: 'Error, la valorizacion de la frecuencia no coicide con ninguno de los rangos esperados.'
      })
      return
    }
    objData.id_escalEficFrec = filteRageEscalFrecuen[0].id_escalEfic
    // ------------------------------------------------------------------- capturar el Id de data la escala de eficacia de la impacto
    const filteRageImpacEscal = listDegradEscal.filter((item) => {
      const rangeDate = item.rangValEscalEfic.split(' - ')
      return (parseInt(rangeDate[0]) <= parseInt(objData.valEficDegr)) && (parseInt(objData.valEficDegr) <= parseInt(rangeDate[1]))
    })
    // console.log(filteRageImpacEscal)
    if (filteRageImpacEscal.length === 0) {
      res.send({
        status: 200,
        typo: 'error',
        messege: 'Error, la valorizacion del impacto no coicide con ninguno de los rangos esperados.'
      })
      return
    }
    objData.id_escalEficImpac = filteRageImpacEscal[0].id_escalEfic
    // --------------------------------------------------------------
    const result = await objvalorSalvAfectAct.actualise_valorEficacia(req, res, true, objData)
    // cargar los calculos en la informacion a la base de datos
    await this.cagarInforValorizacion(req, res, objData.id_salvAfectAct)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }

  async cagarInforValorizacion (req, res, idSalvAfectAct) {
    // leer la valorizacion de la eficacia
    const result = await objvalorSalvAfectAct.read_valoreficacia(req, res, idSalvAfectAct)
    if (parseInt(result.length) === 0) return false
    const objResul = result[0]
    console.log(objResul)
    await objvalorSalvAfectAct.loadProm_valoreficacia(req, res, objResul.id_valorEficacia)
    // ----------------------------------------------------------------------------------- cargar la valorizacion de la amenaza de dimensiones
    // informacion de la valorizacion de la amenaza
    const listResulAnali = await objvaloriAmenas.list_valorafectamen(req, res, objResul.id_afectaActiv)
    if (parseInt(listResulAnali.length) === 0) return false
    const objResulAnali = listResulAnali[0]
    // informacion de la valorizacion por dimensiones de la amenaza
    const listDimenValori = await objvaloriAmenasDim.list_valAfectAmenDimen(req, res, objResulAnali.id_valorAfectAmen)
    if (parseInt(listDimenValori.length) === 0) return false
    // capturar las escalas residual
    const listEscalDegResid = await objescalDegrResid.liest_escaladegradresidual(req, res)
    const listEscalFreResid = await objescalFrecuResid.liest_escalafrecuenresidual(req, res)
    const listEscalImpResid = await objescalImpacResid.liest_escalaimpactoresidual(req, res)
    const listEscalRieResid = await objescalRiesgResid.liest_escalariesgoresidual(req, res)
    // cargar la valorizacion del de las dimenciones y sacar el riesgo intrinseco
    const filterListDimenValori = listDimenValori.map((item) => {
      // console.log(item)
      // console.log(objResul)
      // console.log(objResulAnali)
      // console.log(item)
      const ObjDimen = {
        id_valorEficacia: objResul.id_valorEficacia,
        id_dimension: item.id_dimension,
        id_escalDegradResid: 0,
        valEscalDegradResid: 0,
        id_escalFrecuenResid: 0,
        valEscalFrecuenResid: 0,
        id_escalImpaResid: 0,
        valEscalImpaResid: 0,
        id_escalRiesgResid: 0,
        valEscalRiesgResid: 0
      }
      // --------------------------------------------------------------- CALCULO DEGRADACION RESIDUAL
      // DR = DG * (1 - Edg)
      const valEscalDegradResid = parseFloat(((item.valorDegrad / 100) * (1 - (objResul.valEficDegr / 100))).toFixed(2))
      ObjDimen.valEscalDegradResid = valEscalDegradResid
      const listIdEscalDegradResid = listEscalDegResid.filter((escalDegradResid) => {
        const rangeEscalDegradResid = escalDegradResid.rangValEscalDegradResid.split(' - ')
        return ((parseFloat(rangeEscalDegradResid[0]) <= valEscalDegradResid) && (valEscalDegradResid <= parseFloat(rangeEscalDegradResid[1])))
      })
      const ObjValEscalDegradResid = listIdEscalDegradResid[0]
      ObjDimen.id_escalDegradResid = ObjValEscalDegradResid.id_escalDegradResid
      // console.log('-------------------------------- Degradacion')
      // console.log(objResul.valEficDegr)
      // console.log(item.valorDegrad)
      // console.log(valEscalDegradResid)
      // console.log(listIdEscalDegradResid)
      // --------------------------------------------------------------- CALCULO FRECUENCIA RESIDUAL
      // FR = FC * (1 - Efc)
      const valEscalFrecResid = ((item.valueCualiFrecue) * (1 - (objResul.valEficFrec / 100)))
      ObjDimen.valEscalFrecuenResid = parseFloat(valEscalFrecResid.toFixed(2))
      const listIdEscalFrecResid = listEscalFreResid.filter((escalFrecResid) => {
        const rangeEscalFregResid = escalFrecResid.rangValEscalFrecuenResid.split(' - ')
        return ((parseFloat(rangeEscalFregResid[0]) <= valEscalFrecResid) && (valEscalFrecResid <= parseFloat(rangeEscalFregResid[1])))
      })
      const ObjValEscalFrecResid = listIdEscalFrecResid[0]
      const valueCualitiEscalFrecuenResid = ObjValEscalFrecResid.valorEscalFrecuenResid
      ObjDimen.id_escalFrecuenResid = ObjValEscalFrecResid.id_escalFrecuenResid
      // console.log('-------------------------------- Frecuencia')
      // console.log(objResul.valEficFrec)
      // console.log(item.valueCualiFrecue)
      // console.log(valEscalFrecResid)
      // console.log(listIdEscalFrecResid)
      // --------------------------------------------------------------- CALCULO IMPACTO RESIDUAL
      // IR = NR * (ROUND(DR *10) * 10)
      // (ROUND(DR *10) * 10) es una normalizacion que se hace con la degradacion residual
      // Round(0,15 * 10) = 2 => 2 * 10 = 20
      const NormaliceDegradResid = (Math.round(valEscalDegradResid * 10) * 10) / 100
      const valEscalImpResid = parseFloat(((item.valorCualiRiesg) * (NormaliceDegradResid)).toFixed(2))
      ObjDimen.valEscalImpaResid = valEscalImpResid
      const listIdEscalImpacResid = listEscalImpResid.filter((escalImpResid) => {
        const rangeEscalImpResid = escalImpResid.rangValEscalImpaResid.split(' - ')
        return ((parseFloat(rangeEscalImpResid[0]) <= valEscalImpResid) && (valEscalImpResid <= parseFloat(rangeEscalImpResid[1])))
      })
      const ObjValEscalImpacResid = listIdEscalImpacResid[0]
      const valueCualitiEscalImpacResid = ObjValEscalImpacResid.valorEscalImpaResid
      ObjDimen.id_escalImpaResid = ObjValEscalImpacResid.id_escalImpaResid
      // console.log('-------------------------------- Impacto')
      // console.log(NormaliceDegradResid)
      // console.log(item.valorCualiRiesg)
      // console.log(valEscalImpResid)
      // console.log(listIdEscalImpacResid)
      // --------------------------------------------------------------- CALCULO RIESGO RESIDUAL
      // RR = IR * PR
      // const NormaliceDegradResid = (Math.round(valEscalDegradResid * 10) * 10) / 100
      const valEscalRiesgResid = ((valueCualitiEscalFrecuenResid) * (valueCualitiEscalImpacResid))
      ObjDimen.valEscalRiesgResid = valEscalRiesgResid
      const listIdEscalRiesgResid = listEscalRieResid.filter((escalRiesgResid) => {
        const rangeEscalRiesgResid = escalRiesgResid.rangValEscalRiesgResid.split(' - ')
        return ((parseFloat(rangeEscalRiesgResid[0]) <= valEscalRiesgResid) && (valEscalRiesgResid <= parseFloat(rangeEscalRiesgResid[1])))
      })
      const ObjValEscalRiesgResid = listIdEscalRiesgResid[0]
      ObjDimen.id_escalRiesgResid = ObjValEscalRiesgResid.id_escalRiesgResid
      // console.log('-------------------------------- RIESGO')
      // console.log(valueCualitiEscalFrecuenResid)
      // console.log(valueCualitiEscalImpacResid)
      // console.log(valEscalRiesgResid)
      // console.log(listIdEscalRiesgResid)
      return ObjDimen
    })
    // cargar la valorizacion de las dimensiones teniendo en cuenta la eficacia
    for (let index = 0; index < filterListDimenValori.length; index++) {
      const element = filterListDimenValori[index]
      console.log(element)
      await objvalorSalvAfectAct.actualise_valorEficaciaDim(req, res, element)
    }
  }

  async read_valoreficacia (req, res) {
    const result = await objvalorSalvAfectAct.read_valoreficacia(req, res)
    res.json(result)
  }
}
