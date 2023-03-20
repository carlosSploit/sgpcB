// const Validator = require('../../../config/complementos/validator')
// const objvalit = new Validator()
const BdvaloriActiv = require('../../model/v2/valoriActiv.bd')
const objvaloriActiv = new BdvaloriActiv()
const BdvaloriActivDim = require('../../model/v2/valoriActivDim.bd')
const objvaloriActivDim = new BdvaloriActivDim()
const Bdnivelvalor = require('../../model/v2/nivelvalor.bd')
const objnivelvalor = new Bdnivelvalor()

module.exports = class ngvaloriActiv {
  async inser_valoriActivDimen (req, res) {
    // se comprueba si se an enviado las dimenciones valorizadas
    if (req.body.dataValor.length === 0) {
      res.send({
        status: 404,
        typo: 'error',
        messege: 'No presenta una valorizacion de dimensiones, Ingresar dimensiones porfavor.',
        data: []
      })
      // eslint-disable-next-line no-useless-return
      return
    }
    // comprovamos si todos las dimensionesque se van a valorizar hay nuevas si
    // esque hay valorizacion

    const listDimendData = await objvaloriActivDim.list_valoriActivDimen(req, res, req.body.id_valorActiv)
    if (listDimendData.length !== 0) {
      // capturar las dimensiones que se an valorizado antes
      const listDimekey = listDimendData.map((item) => { return item.id_dimension })
      const newListDimekey = req.body.dataValor.map((item) => { return item.id_dimension })
      // verificar se verifica si se an quitado dimensiones
      const listNewInsercion = listDimekey.filter((item) => {
        return parseInt(newListDimekey.indexOf(item)) === -1
      })
      // elimina a todas las dimensiones que ya no se esten dando valorizacion
      for (let index = 0; index < listNewInsercion.length; index++) {
        const element = listNewInsercion[index]
        // se captura la informacion de la dimencion para su posterior eliminacion
        let dataDimen = listDimendData.filter((item) => {
          return parseInt(item.id_dimension) === parseInt(element)
        })
        if (dataDimen.length === 0) break
        dataDimen = dataDimen[0]
        // eliminacion de las dimensiones que ya no se desee una valorizacion
        await objvaloriActivDim.eliminar_valoriActivDimen(req, res, dataDimen.id_valorActiDimen)
      }
    }
    // se realiza la insercion o actualizacion de cada una de las valorizaciones
    for (let index = 0; index < req.body.dataValor.length; index++) {
      let element = req.body.dataValor[index]
      // verifica si la insercion se dio por valorizacion o por insercion por escala
      if (!(element.valorAcivCualit >= 0 && element.valorAcivCualit <= 10)) {
        res.send({
          status: 404,
          typo: 'error',
          messege: `La dimencion con codigo ${element.id_dimension} presenta una valorizacion esta fuera del rango`
        })
        return
      }
      console.log(element)
      // se le captura su nivel de valorizacion
      const ObjnivelVal = await this.verifiEscalValori(req, res, element.valorAcivCualit)
      element = { id_nivelCritec: ObjnivelVal.id_nivelValor, id_valorActiv: req.body.id_valorActiv, ...element }
      await objvaloriActivDim.inser_valoriActivDimen(req, res, true, { ...element })
    }

    await objvaloriActiv.loadProm_valoractiv(req, res, req.body.id_valorActiv)
    // const result = await objvaloriActivDim.inser_valoriActivDimen(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: 'La actualizacion se realizo correctamente'
    })
  }

  async verifiEscalValori (req, res, valorAcivCualit = 0) {
    const rangeValori = await objnivelvalor.list_nivelvalor(req, res)
    const itemvalor = rangeValori.filter((item) => {
      const filterRange = item.rangValid.split(' - ').map((item) => { return parseInt(item) })
      // console.log(`${(filterRange[0] <= valorAcivCualit)} && ${(filterRange[1] >= valorAcivCualit)} = ${(filterRange[0] <= valorAcivCualit) && (filterRange[1] >= valorAcivCualit)}`)
      // console.log(`${filterRange[0]} <= ${valorAcivCualit}  && ${filterRange[1]} >= ${valorAcivCualit} = ${(filterRange[0] <= valorAcivCualit) && (filterRange[1] >= valorAcivCualit)}`)
      return (filterRange[0] <= valorAcivCualit) && (filterRange[1] >= valorAcivCualit)
    })
    return itemvalor[0]
  }

  // async actualizar_valoractiv (req, res) {
  //   // validar datos insertados
  //   const validado = Valideinsert(req)

  //   if (validado.valida) {
  //     res.send({
  //       status: 404,
  //       typo: 'error',
  //       messege: 'Casillas mal ingresadas',
  //       data: validado.auxvalidetdata
  //     })
  //     // eslint-disable-next-line no-useless-return
  //     return
  //   }

  //   // si todo esta correcto, inserta los datos
  //   const result = await objvaloriActiv.actualizar_valoractiv(req, res)
  //   res.send({
  //     status: 200,
  //     typo: 'succes',
  //     messege: result
  //   })
  // }

  async list_valoriActivDimen (req, res) {
    const result = await objvaloriActivDim.list_valoriActivDimen(req, res)
    res.json(result)
  }

  async eliminar_valoriActivDimen (req, res) {
    const result = await objvaloriActivDim.eliminar_valoriActivDimen(req, res)
    res.json(result)
  }
}
