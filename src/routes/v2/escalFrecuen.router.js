const express = require('express')
const rooutes = express.Router()
const NegescalDegrad = require('../../negocio/v2/escalFrecuen.negocio')
const objescalFrecuen = new NegescalDegrad()
// ######################### rooutes ###################################

// List
rooutes.get('/', async (req, res) => {
  objescalFrecuen.list_escalafrecuencia(req, res)
})

// insertar
rooutes.post('/', async (req, res) => {
  objescalFrecuen.inser_escalFrecuen(req, res)
})

// delete
// rooutes.delete('/:id_areaProce', async (req, res) => {
//   objareainterproce.eliminar_areainterproce(req, res)
// })

module.exports = rooutes
