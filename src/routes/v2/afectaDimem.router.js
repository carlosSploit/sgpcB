const express = require('express')
const rooutes = express.Router()
const NegafectaDimem = require('../../negocio/v2/afectaDimem.negocio')
const objafectaDimem = new NegafectaDimem()
// ######################### rooutes ###################################

// List
rooutes.get('/', async (req, res) => {
  objafectaDimem.list_afectaDimem(req, res)
})

// insertar
rooutes.post('/', async (req, res) => {
  objafectaDimem.inser_afectaDimem(req, res)
})

// delete
// rooutes.delete('/:id_areaProce', async (req, res) => {
//   objareainterproce.eliminar_areainterproce(req, res)
// })

module.exports = rooutes
