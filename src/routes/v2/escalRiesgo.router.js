const express = require('express')
const rooutes = express.Router()
const NegescalRiesgo = require('../../negocio/v2/escalRiesgo.negocio')
const objescalRiesgo = new NegescalRiesgo()
// ######################### rooutes ###################################

// List
rooutes.get('/', async (req, res) => {
  objescalRiesgo.list_escalRiesgo(req, res)
})

// insertar
rooutes.post('/', async (req, res) => {
  objescalRiesgo.inser_escalRiesgo(req, res)
})

// delete
// rooutes.delete('/:id_areaProce', async (req, res) => {
//   objareainterproce.eliminar_areainterproce(req, res)
// })

module.exports = rooutes
