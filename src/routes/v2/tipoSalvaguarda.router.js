const express = require('express')
const rooutes = express.Router()
const NegtipoSalvaguarda = require('../../negocio/v2/tipoSalvaguarda.negocio')
const objtipoSalvaguarda = new NegtipoSalvaguarda()
// ######################### rooutes ###################################

// List
rooutes.get('/', async (req, res) => {
  objtipoSalvaguarda.list_tiposalvaguarda(req, res)
})

// insertar
rooutes.post('/', async (req, res) => {
  objtipoSalvaguarda.inser_tiposalvaguarda(req, res)
})

// delete
// rooutes.delete('/:id_areaProce', async (req, res) => {
//   objareainterproce.eliminar_areainterproce(req, res)
// })

module.exports = rooutes
