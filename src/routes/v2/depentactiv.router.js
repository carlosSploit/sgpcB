const express = require('express')
const rooutes = express.Router()
const Negdepentactiv = require('../../negocio/v2/depentactiv.negocio')
const objdepentactiv = new Negdepentactiv()
// ######################### rooutes ###################################

// List
rooutes.get('/:id_activproc', async (req, res) => {
  objdepentactiv.list_depentactiv(req, res)
})

// insertar
rooutes.post('/', async (req, res) => {
  objdepentactiv.inser_depentactiv(req, res)
})

// delete
rooutes.delete('/:id_depenActiv', async (req, res) => {
  objdepentactiv.eliminar_depentactiv(req, res)
})

module.exports = rooutes
