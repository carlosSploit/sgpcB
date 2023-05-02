const express = require('express')
const rooutes = express.Router()
const Negproceempresa = require('../../negocio/v2/proceempresa.negocio')
const objproceempresa = new Negproceempresa()
// ######################### rooutes ###################################

// List
rooutes.get('/:id_empresa', async (req, res) => {
  const proce = await objproceempresa.list_proceempresa(req, res)
  res.json(proce)
})

// insertar
rooutes.post('/', async (req, res) => {
  objproceempresa.inser_proceempresa(req, res)
})

// delete
rooutes.delete('/:id_proceso', async (req, res) => {
  objproceempresa.eliminar_proceempresa(req, res)
})

// actualizar
rooutes.put('/:id_proceso', async (req, res) => {
  objproceempresa.actualise_proceempresa(req, res)
})

module.exports = rooutes
