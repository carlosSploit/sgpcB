const BdvaloriAmenas = require('../../model/v2/valoriAmenas.bd')
const objvaloriAmenas = new BdvaloriAmenas()
const NegvaloriAmenasDim = require('./valoriAmenasDim.negocio')
const objvaloriAmenasDim = new NegvaloriAmenasDim()

async function validarValoriAmenaz (req, res, idAfectaActiv) {
  // comprobar la informacion de la valoriazion de la amenaza
  const listResult = await objvaloriAmenas.list_valorafectamen(req, res, idAfectaActiv)
  if (parseInt(listResult.length) === 0) return false
  const objResul = listResult[0]
  // comprobar la valorizacion final
  const resulComprueb = await objvaloriAmenasDim.compruebeExistenValori(req, res, objResul.id_valorAfectAmen)
  return resulComprueb.data
}

module.exports = class ngvaloriActiv {
  async compruebeExistenValori (req, res) {
    const result = await validarValoriAmenaz(req, res, req.body.id_afectaActiv)
    // // eslint-disable-next-line no-useless-return
    return {
      status: (result) ? 200 : 404,
      typo: (result) ? 'succes' : 'error',
      messege: (result) ? 'La valorizacion de la amenaza puede ser ingresado.' : 'La valorizacion no puede ser insertada',
      data: result
    }
  }

  async insert_valorafectamen (req, res) {
    // validar si se inserto los datos de la valorizacion del activo
    const resultData = await this.compruebeExistenValori(req, res, req.body.id_afectaActiv)
    if (!resultData.data) {
      res.send(resultData)
      return
    }
    // se realiza la insercion de la valorizacion de forma generica
    const result = await objvaloriAmenas.insert_valorafectamen(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }

  async actualizar_valorafectamen (req, res) {
    // validar datos insertados
    // si todo esta correcto, inserta los datos
    const result = await objvaloriAmenas.actualizar_valorafectamen(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }

  async list_valorafectamen (req, res) {
    const result = await objvaloriAmenas.list_valorafectamen(req, res)
    res.json(result)
  }

  // async eliminar_areasempresa (req, res) {
  //   const result = await objareasempresa.eliminar_areasempresa(req, res)
  //   res.json(result)
  // }
}
