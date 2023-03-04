// const Validator = require('../../config/complementos/validator')
// const objvalit = new Validator()
const Bdanaliticas = require('../model/bd_analiticas')
const objbdanaliticas = new Bdanaliticas()

module.exports = class ngadmin {
  async list_analiticas_ciclo_sincrono (req, res) {
    // let results = await conexibd.single_query(req, res,'CALL `list_admin`(?);',[req.params.name])
    // return (Array.isArray(results))?results:[];
    const result = await objbdanaliticas.list_analiticas_ciclo_sincrono(req, res)
    res.json(result)
  }

  async list_analiticas_ciclo_sincrono_puntos (req, res) {
    // let results = await conexibd.single_query(req, res,'CALL `list_admin`(?);',[req.params.name])
    // return (Array.isArray(results))?results:[];
    const result = await objbdanaliticas.list_analiticas_ciclo_sincrono_puntos(
      req,
      res
    )
    const orderdata = result.sort((actu, poster) => {
      return parseInt(actu.sumatotal) - parseInt(poster.sumatotal)
    }).reverse().map((item, ind) => {
      return { puesto: ind + 1, ...item }
    })
    // console.log(orderdata)
    res.json(orderdata)
  }
}
