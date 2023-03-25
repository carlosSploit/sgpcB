const express = require('express')
const rooutes = express.Router()
const NegrecurSalvAfectActect = require('../../negocio/v2/recurSalvAfectAct.negocio')
const objrecurSalvAfectAct = new NegrecurSalvAfectActect()
// ######################### rooutes ###################################

// List
rooutes.get('/:id_salvAfectAct', async (req, res) => {
  objrecurSalvAfectAct.list_recurSalvAfectAct(req, res)
})

// insertar
rooutes.post('/', async (req, res) => {
  objrecurSalvAfectAct.insert_recurSalvAfectAct(req, res)
})

// delete
rooutes.delete('/:id_recurSalvAfectAct', async (req, res) => {
  objrecurSalvAfectAct.eliminar_recurSalvAfectAct(req, res)
})

// actualizar
rooutes.put('/:id_recurSalvAfectAct', async (req, res) => {
  objrecurSalvAfectAct.actualise_recurSalvAfectAct(req, res)
})

module.exports = rooutes
