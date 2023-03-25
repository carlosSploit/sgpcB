const express = require('express')
const rooutes = express.Router()
const NegescalEficacia = require('../../negocio/v2/escalEficacia.negocio')
const objescalEficacia = new NegescalEficacia()
// ######################### rooutes ###################################

// List
rooutes.get('/', async (req, res) => {
  objescalEficacia.list_escalEficacia(req, res)
})

// insertar
rooutes.post('/', async (req, res) => {
  objescalEficacia.inser_escalaefica(req, res)
})

// delete
// rooutes.delete('/:id_areaProce', async (req, res) => {
//   objareainterproce.eliminar_areainterproce(req, res)
// })

module.exports = rooutes
