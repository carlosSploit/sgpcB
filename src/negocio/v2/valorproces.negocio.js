const Bdvalorproces = require('../../model/v2/valorproces.bd')
const objvalorproces = new Bdvalorproces()

module.exports = class ngclienAnalit {
  async actualise_valorproces (req, res) {
    // si todo esta correcto, inserta los datos
    const result = await objvalorproces.actualise_valorproces(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }

  async read_valorproces (req, res) {
    const result = await objvalorproces.read_valorproces(req, res)
    res.json(result)
  }
}
