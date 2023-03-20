const express = require('express')
const rooutes = express.Router()
const NegescalImpact = require('../../negocio/v2/escalImpact.negocio')
const objescalImpact = new NegescalImpact()
// ######################### rooutes ###################################

// List
rooutes.get('/', async (req, res) => {
  objescalImpact.list_escalaimpacto(req, res)
})

// insertar
rooutes.post('/', async (req, res) => {
  objescalImpact.inser_escalaimpacto(req, res)
})

// delete
// rooutes.delete('/:id_areaProce', async (req, res) => {
//   objareainterproce.eliminar_areainterproce(req, res)
// })

module.exports = rooutes
