const express = require('express')
const rooutes = express.Router()
const Negresposproce = require('../../negocio/v2/resposproce.negocio')
const objresposproce = new Negresposproce()
// ######################### rooutes ###################################

// List
rooutes.get('/:id_proceso', async (req, res) => {
  objresposproce.list_areasempresa(req, res)
})

// insertar
rooutes.post('/', async (req, res) => {
  objresposproce.inser_resposproce(req, res)
})

// delete
rooutes.delete('/:id_resposProce', async (req, res) => {
  objresposproce.eliminar_resposproce(req, res)
})

module.exports = rooutes
