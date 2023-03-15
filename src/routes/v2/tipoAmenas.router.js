const express = require('express')
const rooutes = express.Router()
const NegtipAmenas = require('../../negocio/v2/tipAmenas.negocio')
const objtipAmenas = new NegtipAmenas()
// ######################### rooutes ###################################

// List
rooutes.get('/', async (req, res) => {
  objtipAmenas.list_tipoAmenasa(req, res)
})

// insertar
rooutes.post('/', async (req, res) => {
  objtipAmenas.inser_tipoamen(req, res)
})

// delete
// rooutes.delete('/:id_areaProce', async (req, res) => {
//   objareainterproce.eliminar_areainterproce(req, res)
// })

module.exports = rooutes
