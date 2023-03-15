const express = require('express')
const rooutes = express.Router()
const NegescalDegrad = require('../../negocio/v2/escalDegrad.negocio')
const objescalDegrad = new NegescalDegrad()
// ######################### rooutes ###################################

// List
rooutes.get('/', async (req, res) => {
  objescalDegrad.list_escaladegrad(req, res)
})

// insertar
rooutes.post('/', async (req, res) => {
  objescalDegrad.inser_escalDegrad(req, res)
})

// delete
// rooutes.delete('/:id_areaProce', async (req, res) => {
//   objareainterproce.eliminar_areainterproce(req, res)
// })

module.exports = rooutes
