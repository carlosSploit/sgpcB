const express = require('express')
const rooutes = express.Router()
const Negproceempresa = require('../../negocio/v2/proceempresa.negocio')
const objproceempresa = new Negproceempresa()
// ######################### rooutes ###################################

// List
rooutes.get('/:id_empresa', async (req, res) => {
  objproceempresa.list_proceempresa(req, res)
})

// insertar
rooutes.post('/', async (req, res) => {
  objproceempresa.inser_proceempresa(req, res)
})

// delete
rooutes.delete('/:id_trabajador', async (req, res) => {
  objproceempresa.eliminar_trabEmpresa(req, res)
})

// actualizar
rooutes.put('/:id_trabajador', async (req, res) => {
  objproceempresa.actualise_trabajempresa(req, res)
})

module.exports = rooutes
