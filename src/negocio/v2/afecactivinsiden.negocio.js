const Bdafecactivinsiden = require('../../model/v2/afecactivinsiden.bd')
const objafecactivinsiden = new Bdafecactivinsiden()

const valideInserInsidenAmenas = async (req, res) => {
  try {
    const idAfectaActiv = req.body.id_afectaActiv
    const idInsidencia = req.body.id_insidencia
    const resultCom = await objafecactivinsiden.list_afecactivinsiden(req, res, idAfectaActiv)
    const filterData = resultCom.filter((item) => {
      return parseInt(item.id_insidencia) === parseInt(idInsidencia)
    })
    console.log(resultCom)
    return filterData.length > 0
  } catch (error) {
    return true
  }
}

module.exports = class ngclienAnalit {
  async insert_afecactivinsiden (req, res) {
    // validar datos insertados
    const resulValid = await valideInserInsidenAmenas(req, res)

    if (resulValid) {
      res.send({
        status: 404,
        typo: 'error',
        messege: 'La insiedencia ya fue designado a la amenaza.',
        data: []
      })
      return
    }

    const result = await objafecactivinsiden.insert_afecactivinsiden(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }

  async list_afecactivinsiden (req, res) {
    const result = await objafecactivinsiden.list_afecactivinsiden(req, res)
    res.json(result)
  }

  async eliminar_afecactivinsiden (req, res) {
    const result = await objafecactivinsiden.eliminar_afecactivinsiden(req, res)
    res.json(result)
  }
}
