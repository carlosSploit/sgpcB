const express = require('express')
const rooutes = express.Router()
const NegescalFrecueResid = require('../../negocio/v2/escalFrecueResid.negocio')
const objescalFrecueResid = new NegescalFrecueResid()
// ######################### rooutes ###################################

// List
rooutes.get('/', async (req, res) => {
  objescalFrecueResid.liest_escalafrecuenresidual(req, res)
})

// insertar
rooutes.post('/', async (req, res) => {
  objescalFrecueResid.inser_escalafrecuenresidual(req, res)
})

// delete
// rooutes.delete('/:id_areaProce', async (req, res) => {
//   objareainterproce.eliminar_areainterproce(req, res)
// })

module.exports = rooutes
