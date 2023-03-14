const express = require('express')
const rooutes = express.Router()
const Negnivelvalor = require('../../negocio/v2/nivelvalor.negocio')
const objnivelvalor = new Negnivelvalor()
// ######################### rooutes ###################################

// List
rooutes.get('/', async (req, res) => {
  objnivelvalor.list_nivelvalor(req, res)
})

// insertar
// rooutes.post('/', async (req, res) => {
//   objtipocritevalor.inser_tipocritervalor(req, res)
// })

// delete
// rooutes.delete('/:id_areaProce', async (req, res) => {
//   objareainterproce.eliminar_areainterproce(req, res)
// })

module.exports = rooutes
