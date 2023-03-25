const express = require('express')
const rooutes = express.Router()
const Negsalvaguardas = require('../../negocio/v2/salvaguardas.negocio')
const objsalvaguardas = new Negsalvaguardas()
// ######################### rooutes ###################################

// List
rooutes.get('/:id_tipoSalvg', async (req, res) => {
  objsalvaguardas.list_salvaguardas(req, res)
})

// insertar
rooutes.post('/', async (req, res) => {
  objsalvaguardas.inser_salvaguardas(req, res)
})

// delete
// rooutes.delete('/:id_areaProce', async (req, res) => {
//   objareainterproce.eliminar_areainterproce(req, res)
// })

module.exports = rooutes
