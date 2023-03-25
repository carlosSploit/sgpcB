const express = require('express')
const rooutes = express.Router()
const Negsalvafectact = require('../../negocio/v2/salvafectact.negocio')
const objsalvafectact = new Negsalvafectact()
// ######################### rooutes ###################################

// List
rooutes.get('/:id_afectaActiv', async (req, res) => {
  objsalvafectact.list_salvAfectAct(req, res)
})

// read
// rooutes.get('/read/:id_clienAnalit', async (req, res) => {
//   objempresa.read_clienAnalit(req, res)
// })

// insertar
rooutes.post('/', async (req, res) => {
  objsalvafectact.insert_salvAfectAct(req, res)
})

// delete
rooutes.delete('/:id_salvAfectAct', async (req, res) => {
  objsalvafectact.delete_salvAfectAct(req, res)
})

// actualizar
rooutes.put('/:id_salvAfectAct', async (req, res) => {
  objsalvafectact.actualizo_salvAfectAct(req, res)
})

module.exports = rooutes
