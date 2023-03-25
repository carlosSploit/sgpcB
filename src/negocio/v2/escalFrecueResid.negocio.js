const BdescalFrecuResid = require('../../model/v2/escalFrecuResid.bd')
const objescalFrecuResid = new BdescalFrecuResid()

module.exports = class NegEscalafrecuenresidual {
  async inser_escalafrecuenresidual (req, res) {
    const result = await objescalFrecuResid.inser_escalafrecuenresidual(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }

  async liest_escalafrecuenresidual (req, res) {
    const result = await objescalFrecuResid.liest_escalafrecuenresidual(req, res)
    res.json(result)
  }
}
