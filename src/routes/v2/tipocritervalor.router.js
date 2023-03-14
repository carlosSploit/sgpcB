const express = require('express')
const rooutes = express.Router()
const Negtipocritevalor = require('../../negocio/v2/tipocritevalor.negocio')
const objtipocritevalor = new Negtipocritevalor()
// ######################### rooutes ###################################

// List
rooutes.get('/', async (req, res) => {
  objtipocritevalor.list_tipocritervalort(req, res)
})

// insertar
rooutes.post('/', async (req, res) => {
  objtipocritevalor.inser_tipocritervalor(req, res)
})

// delete
// rooutes.delete('/:id_areaProce', async (req, res) => {
//   objareainterproce.eliminar_areainterproce(req, res)
// })

module.exports = rooutes
