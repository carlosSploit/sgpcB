const express = require('express')
const rooutes = express.Router()
const Ngcontactiv = require('../negocio/contactiv.negocio')
const objcontactiv = new Ngcontactiv()
// ######################### rooutes ###################################
// listar
rooutes.get('/:idsession', async (req, res) => {
  objcontactiv.list_contactiva(req, res)
})

// delect
rooutes.delete('/:idcontactv', async (req, res) => {
  objcontactiv.delect_contactiva(req, res)
})

// insertar
rooutes.post('/', async (req, res) => {
  objcontactiv.inser_contactiva(req, res)
})

// actualizar
rooutes.put('/:idcontactv', async (req, res) => {
  objcontactiv.actualise_contactiva(req, res)
})

module.exports = rooutes
