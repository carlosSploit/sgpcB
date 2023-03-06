const express = require('express')
const rooutes = express.Router()
const Negareainterproce = require('../../negocio/v2/areainterproce.negocio')
const objareainterproce = new Negareainterproce()
// ######################### rooutes ###################################

// List
rooutes.get('/:id_proceso', async (req, res) => {
  objareainterproce.list_areainterproce(req, res)
})

// insertar
rooutes.post('/', async (req, res) => {
  objareainterproce.inser_areainterproce(req, res)
})

// delete
rooutes.delete('/:id_areaProce', async (req, res) => {
  objareainterproce.eliminar_areainterproce(req, res)
})

module.exports = rooutes
