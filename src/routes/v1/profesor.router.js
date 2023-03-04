const express = require('express')
const rooutes = express.Router()
const Negprofe = require('../negocio/profesor.negocio')
const objprofe = new Negprofe()
// ######################### rooutes ###################################
// listar
rooutes.get('/', async (req, res) => {
  objprofe.list_profe(req, res)
})
// listar
rooutes.get('/:name', async (req, res) => {
  objprofe.list_profe(req, res)
})

// listar
rooutes.get('/read/:id_profe', async (req, res) => {
  objprofe.read_profe(req, res)
})

// delect
rooutes.delete('/:id_profe', async (req, res) => {
  objprofe.delect_profe(req, res)
})

// insertar
rooutes.post('/', async (req, res) => {
  objprofe.inser_profe(req, res)
})

// actualizar
rooutes.put('/:id_profe', async (req, res) => {
  objprofe.actuali_profe(req, res)
})

module.exports = rooutes
