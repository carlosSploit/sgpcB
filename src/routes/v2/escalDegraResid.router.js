const express = require('express')
const rooutes = express.Router()
const NegescalDegraResid = require('../../negocio/v2/escalDegraResid.negocio')
const objescalDegraResid = new NegescalDegraResid()
// ######################### rooutes ###################################

// List
rooutes.get('/', async (req, res) => {
  objescalDegraResid.liest_escaladegradresidual(req, res)
})

// insertar
rooutes.post('/', async (req, res) => {
  objescalDegraResid.inser_escaladegradresidual(req, res)
})

// delete
// rooutes.delete('/:id_areaProce', async (req, res) => {
//   objareainterproce.eliminar_areainterproce(req, res)
// })

module.exports = rooutes
