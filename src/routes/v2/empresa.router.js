const express = require('express')
const rooutes = express.Router()
const Negempresa = require('../../negocio/v2/empresa.negocio')
const objempresa = new Negempresa()
// ######################### rooutes ###################################

// List
rooutes.get('/:id_clienAnalit', async (req, res) => {
  objempresa.list_empresa(req, res)
})

// read
// rooutes.get('/read/:id_clienAnalit', async (req, res) => {
//   objempresa.read_clienAnalit(req, res)
// })

// insertar
rooutes.post('/', async (req, res) => {
  objempresa.inser_empresa(req, res)
})

// actualizar
// rooutes.put('/:id_clienAnalit', async (req, res) => {
//   objempresa.actuali_clienAnalit(req, res)
// })

// actualizar
// rooutes.put('/infoCuenta/:id_clienAnalit', async (req, res) => {
//   objempresa.actuali_clienAnalitInfoUser(req, res)
// })

module.exports = rooutes
