const express = require('express')
const rooutes = express.Router()
const Negpassalvafect = require('../../negocio/v2/passalvafect.negocio')
const objpassalvafect = new Negpassalvafect()
// ######################### rooutes ###################################

// List
rooutes.get('/:id_salvAfectAct', async (req, res) => {
  objpassalvafect.list_passalvafect(req, res)
})

// insertar
rooutes.post('/', async (req, res) => {
  objpassalvafect.insert_passalvafect(req, res)
})

// delete
rooutes.delete('/:id_pasSalvAfec', async (req, res) => {
  objpassalvafect.eliminar_passalvafect(req, res)
})

// actualizar
rooutes.put('/:id_pasSalvAfec', async (req, res) => {
  objpassalvafect.actualise_passalvafect(req, res)
})

module.exports = rooutes
