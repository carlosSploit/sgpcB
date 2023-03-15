const express = require('express')
const rooutes = express.Router()
const Negamenazas = require('../../negocio/v2/amenazas.negocio')
const objamenazas = new Negamenazas()
// ######################### rooutes ###################################

// List
rooutes.get('/:id_tipoActiv', async (req, res) => {
  objamenazas.list_amenas(req, res)
})

// insertar
rooutes.post('/', async (req, res) => {
  objamenazas.inser_amenazas(req, res)
})

// delete
// rooutes.delete('/:id_areaProce', async (req, res) => {
//   objareainterproce.eliminar_areainterproce(req, res)
// })

module.exports = rooutes
