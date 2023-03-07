const express = require('express')
const rooutes = express.Router()
const Negvalorproces = require('../../negocio/v2/valorproces.negocio')
const odjvalorproces = new Negvalorproces()
// ######################### rooutes ###################################

// leer
rooutes.get('/:id_proceso', async (req, res) => {
  odjvalorproces.read_valorproces(req, res)
})

// actualizar
rooutes.put('/:id_valorProc', async (req, res) => {
  odjvalorproces.actualise_valorproces(req, res)
})

module.exports = rooutes
