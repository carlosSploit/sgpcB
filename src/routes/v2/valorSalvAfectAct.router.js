const express = require('express')
const rooutes = express.Router()
const NegvalorSalvAfectAct = require('../../negocio/v2/valorSalvAfectAct.negocio')
const odjvalorSalvAfectAct = new NegvalorSalvAfectAct()
// ######################### rooutes ###################################

// leer
rooutes.get('/:id_salvAfectAct', async (req, res) => {
  odjvalorSalvAfectAct.read_valoreficacia(req, res)
})

// actualizar
rooutes.put('/:id_salvAfectAct', async (req, res) => {
  odjvalorSalvAfectAct.actualise_valorEficacia(req, res)
})

// comprobar
rooutes.get('/comprobar/:id_salvAfectAct', async (req, res) => {
  odjvalorSalvAfectAct.compruebValoriAmenaz(req, res)
})

module.exports = rooutes
