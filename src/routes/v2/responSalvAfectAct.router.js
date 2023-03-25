const express = require('express')
const rooutes = express.Router()
const NegresponSalvAfectAct = require('../../negocio/v2/responSalvAfectAct.negocio')
const objresponSalvAfectAct = new NegresponSalvAfectAct()
// ######################### rooutes ###################################

// List
rooutes.get('/:id_salvAfectAct', async (req, res) => {
  objresponSalvAfectAct.list_responSalvAfectAct(req, res)
})

// insertar
rooutes.post('/', async (req, res) => {
  objresponSalvAfectAct.insert_responSalvAfectAct(req, res)
})

// delete
rooutes.delete('/:id_responSalvAfectAct', async (req, res) => {
  objresponSalvAfectAct.eliminar_responSalvAfectAct(req, res)
})

module.exports = rooutes
