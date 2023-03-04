const verifyToken = require('../../config/tockenizer/tokenizer')
const express = require('express')
const rooutes = express.Router()
const Ngsesion = require('../negocio/sesion.negocio')
const objsesion = new Ngsesion()
// ######################### rooutes ###################################
// listar
rooutes.get('/:id_curso', async (req, res) => {
  objsesion.list_sesion(req, res)
})

// delect
rooutes.delete('/:id_sesion', verifyToken, async (req, res) => {
  objsesion.delect_sesion(req, res)
})

// insertar
rooutes.post('/', verifyToken, async (req, res) => {
  objsesion.inser_sesion(req, res)
})

// actualizar
rooutes.put('/:id_sesion', verifyToken, async (req, res) => {
  objsesion.actualise_sesion(req, res)
})

module.exports = rooutes
