const express = require('express')
const rooutes = express.Router()
const NegAdmin = require('../../negocio/v2/clienAnalit.negocio')
const objclienAnalit = new NegAdmin()
// ######################### rooutes ###################################
// listar
rooutes.get('/', async (req, res) => {
  objclienAnalit.list_clienAnalit(req, res)
})
// listar
rooutes.get('/:nombreCliente', async (req, res) => {
  objclienAnalit.list_clienAnalit(req, res)
})

// listar
rooutes.get('/read/:id_clienAnalit', async (req, res) => {
  objclienAnalit.read_clienAnalit(req, res)
})

// delect
// rooutes.delete('/:id_clienAnalit', async (req, res) => {
//   objclienAnalit.delect_clienAnalit(req, res)
// })

// insertar
rooutes.post('/', async (req, res) => {
  objclienAnalit.inser_clienAnalit(req, res)
})

// actualizar
rooutes.put('/:id_clienAnalit', async (req, res) => {
  objclienAnalit.actuali_clienAnalit(req, res)
})

module.exports = rooutes
