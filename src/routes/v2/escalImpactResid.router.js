const express = require('express')
const rooutes = express.Router()
const NegescalImpactResid = require('../../negocio/v2/escalImpactResid.negocio')
const objescalImpactResid = new NegescalImpactResid()
// ######################### rooutes ###################################

// List
rooutes.get('/', async (req, res) => {
  objescalImpactResid.liest_escalaimpactoresidual(req, res)
})

// insertar
rooutes.post('/', async (req, res) => {
  objescalImpactResid.inser_escalaimpactoresidual(req, res)
})

// delete
// rooutes.delete('/:id_areaProce', async (req, res) => {
//   objareainterproce.eliminar_areainterproce(req, res)
// })

module.exports = rooutes
