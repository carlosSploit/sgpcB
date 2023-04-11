const express = require('express')
const rooutes = express.Router()
const Negempresa = require('../../negocio/v2/empresa.negocio')
const objempresa = new Negempresa()
// ######################### rooutes ###################################

// List
rooutes.get('/:id_clienAnalit', async (req, res) => {
  objempresa.list_empresa(req, res)
})

// List
rooutes.get('/enlace/:id_empresa', async (req, res) => {
  objempresa.list_empresa_enlace(req, res)
})

// read
// rooutes.get('/read/:id_clienAnalit', async (req, res) => {
//   objempresa.read_clienAnalit(req, res)
// })

// insertar
rooutes.post('/', async (req, res) => {
  objempresa.inser_empresa(req, res)
})

// insertar enlace
rooutes.post('/enlace', async (req, res) => {
  objempresa.inser_empresa_enlace(req, res)
})

// delete enlace
rooutes.delete('/enlace/:id_clienAnalit/:id_empresa', async (req, res) => {
  objempresa.eliminar_empresa_enlace(req, res)
})

// delete
rooutes.delete('/:id_empresa', async (req, res) => {
  objempresa.eliminar_empresa(req, res)
})
// actualizar
// rooutes.put('/:id_clienAnalit', async (req, res) => {
//   objempresa.actuali_clienAnalit(req, res)
// })

// actualizar
rooutes.put('/:id_empresa', async (req, res) => {
  objempresa.actuali_empresa(req, res)
})

module.exports = rooutes
