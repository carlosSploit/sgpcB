const express = require('express')
const rooutes = express.Router()
const NegAdmin = require('../negocio/admin.negocio')
const objadmin = new NegAdmin()
// ######################### rooutes ###################################
// listar
rooutes.get('/', async (req, res) => {
  objadmin.list_admin(req, res)
})
// listar
rooutes.get('/:name', async (req, res) => {
  objadmin.list_admin(req, res)
})

// listar
rooutes.get('/read/:id_admin', async (req, res) => {
  objadmin.read_admin(req, res)
})

// delect
rooutes.delete('/:id_admin', async (req, res) => {
  objadmin.delect_admin(req, res)
})

// insertar
rooutes.post('/', async (req, res) => {
  objadmin.inser_admin(req, res)
})

// actualizar
rooutes.put('/:id_admin', async (req, res) => {
  objadmin.actuali_admin(req, res)
})

module.exports = rooutes
