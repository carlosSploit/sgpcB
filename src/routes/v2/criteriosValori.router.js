const express = require('express')
const rooutes = express.Router()
const NegcriteriosValori = require('../../negocio/v2/criteriosValori.negocio')
const objcriteriosValori = new NegcriteriosValori()
// ######################### rooutes ###################################

// List
rooutes.get('/', async (req, res) => {
  objcriteriosValori.list_criteriosValori(req, res)
})

// insertar
rooutes.post('/', async (req, res) => {
  objcriteriosValori.inser_criteriosValori(req, res)
})

// delete
// rooutes.delete('/:id_areaProce', async (req, res) => {
//   objcriteriosValori.list_criteriosValori(req, res)
// })

module.exports = rooutes
