const express = require('express')
const rooutes = express.Router()
const NegtipoActiv = require('../../negocio/v2/tipoActiv.negocio')
const objtipoActiv = new NegtipoActiv()
// ######################### rooutes ###################################

// List
rooutes.get('/:id_tipoActiv', async (req, res) => {
  objtipoActiv.list_tipoActiv(req, res)
})

// insertar
rooutes.post('/', async (req, res) => {
  objtipoActiv.inser_tipoActiv(req, res)
})

// delete
// rooutes.delete('/:id_areaProce', async (req, res) => {
//   objareainterproce.eliminar_areainterproce(req, res)
// })

module.exports = rooutes
