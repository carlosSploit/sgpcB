const BdescalDegrResid = require('../../model/v2/escalDegrResid.bd')
const objescalDegrResid = new BdescalDegrResid()

module.exports = class NegEscalafrecuenresidual {
  async inser_escaladegradresidual (req, res) {
    const result = await objescalDegrResid.inser_escaladegradresidual(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }

  async liest_escaladegradresidual (req, res) {
    const result = await objescalDegrResid.liest_escaladegradresidual(req, res)
    res.json(result)
  }
}
