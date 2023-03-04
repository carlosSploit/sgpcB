const express = require('express')
const rooutes = express.Router()
const Ngpointclass = require('../negocio/pointclass.negocio')
const objadmin = new Ngpointclass()
// ######################### rooutes ###################################
// listar
rooutes.get('/:id_prof', async (req, res) => {
  objadmin.list_puntosclass(req, res)
})

// delect
rooutes.delete('/:id_puntosclass', async (req, res) => {
  objadmin.delect_puntosclass(req, res)
})

// insertar
rooutes.post('/', async (req, res) => {
  objadmin.inser_pointclass(req, res)
})

// insertar default
rooutes.post('/default', async (req, res) => {
  objadmin.inser_pointclass_default(req, res)
})

// actualizar
rooutes.put('/:id_puntosclass', async (req, res) => {
  objadmin.actuali_pointclass(req, res)
})

module.exports = rooutes
