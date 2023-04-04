const express = require('express')
const rooutes = express.Router()
const Negafecactivinsiden = require('../../negocio/v2/afecactivinsiden.negocio')
const objafecactivinsiden = new Negafecactivinsiden()
// ######################### rooutes ###################################

// List
rooutes.get('/:id_afectaActiv', async (req, res) => {
  objafecactivinsiden.list_afecactivinsiden(req, res)
})

// insertar
rooutes.post('/', async (req, res) => {
  objafecactivinsiden.insert_afecactivinsiden(req, res)
})

// delete
rooutes.delete('/:id_afectaActivInsid', async (req, res) => {
  objafecactivinsiden.eliminar_afecactivinsiden(req, res)
})

module.exports = rooutes
