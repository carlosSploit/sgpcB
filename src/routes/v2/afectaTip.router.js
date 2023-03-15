const express = require('express')
const rooutes = express.Router()
const NegafectaTip = require('../../negocio/v2/afectaTip.negocio')
const objafectaTip = new NegafectaTip()
// ######################### rooutes ###################################

// List
rooutes.get('/:id_libreryAmen', async (req, res) => {
  objafectaTip.list_afectaTip(req, res)
})

// insertar
rooutes.post('/', async (req, res) => {
  objafectaTip.inser_afectatip(req, res)
})

// delete
// rooutes.delete('/:id_areaProce', async (req, res) => {
//   objareainterproce.eliminar_areainterproce(req, res)
// })

module.exports = rooutes
