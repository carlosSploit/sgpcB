const express = require('express')
const rooutes = express.Router()
const Negactivproces = require('../../negocio/v2/activproces.negocio')
const objactivproces = new Negactivproces()
// ######################### rooutes ###################################

// List
rooutes.get('/:id_proceso', async (req, res) => {
  objactivproces.list_activproces(req, res)
})

// insertar
rooutes.post('/', async (req, res) => {
  objactivproces.inser_activproces(req, res)
})

// delete
rooutes.delete('/:id_activproc', async (req, res) => {
  objactivproces.eliminar_activproces(req, res)
})

module.exports = rooutes
