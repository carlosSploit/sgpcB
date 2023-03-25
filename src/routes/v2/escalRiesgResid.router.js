const express = require('express')
const rooutes = express.Router()
const NegescalRiesgResid = require('../../negocio/v2/escalRiesgResid.negocio')
const objescalRiesgResid = new NegescalRiesgResid()
// ######################### rooutes ###################################

// List
rooutes.get('/', async (req, res) => {
  objescalRiesgResid.liest_escalariesgoresidual(req, res)
})

// insertar
rooutes.post('/', async (req, res) => {
  objescalRiesgResid.inser_escalariesgoresidual(req, res)
})

// delete
// rooutes.delete('/:id_areaProce', async (req, res) => {
//   objareainterproce.eliminar_areainterproce(req, res)
// })

module.exports = rooutes
