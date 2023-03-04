const express = require('express')
const rooutes = express.Router()
const Negtipotrabaj = require('../negocio/tipocurso.negocio')
const objtipocurso = new Negtipotrabaj()
// ######################### rooutes ###################################
// listar
rooutes.get('/', async (req, res) => {
  objtipocurso.list_tipocurso(req, res)
})

// delect
rooutes.delete('/:id_tipocurso', async (req, res) => {
  objtipocurso.delect_tipocurso(req, res)
})

// insertar
rooutes.post('/', async (req, res) => {
  objtipocurso.inser_tipocurso(req, res)
})

// actualizar
rooutes.put('/:id_tipocurso', async (req, res) => {
  objtipocurso.actuali_tipocurso(req, res)
})

module.exports = rooutes
