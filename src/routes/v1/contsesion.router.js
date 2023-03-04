const express = require('express')
const rooutes = express.Router()
const Ngcontesession = require('../negocio/contesession.negocio')
const objcontesession = new Ngcontesession()
// ######################### rooutes ###################################
// listar
rooutes.get('/:idsession', async (req, res) => {
  objcontesession.list_contesesion(req, res)
})

// delect
rooutes.delete('/:idconteses', async (req, res) => {
  objcontesession.delect_contesesion(req, res)
})

// insertar
rooutes.post('/', async (req, res) => {
  objcontesession.inser_contesesion(req, res)
})

// actualizar
rooutes.put('/:idconteses', async (req, res) => {
  objcontesession.actualise_contesesion(req, res)
})

module.exports = rooutes
