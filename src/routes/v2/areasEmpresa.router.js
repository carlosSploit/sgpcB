const express = require('express')
const rooutes = express.Router()
const Negareasempresa = require('../../negocio/v2/areasEmpresa.negocio')
const objareasempresa = new Negareasempresa()
// ######################### rooutes ###################################

// List
rooutes.get('/:id_empresa', async (req, res) => {
  objareasempresa.list_areasempresa(req, res)
})

// insertar
rooutes.post('/', async (req, res) => {
  objareasempresa.inser_areasempresa(req, res)
})

// delete
rooutes.delete('/:id_areempre', async (req, res) => {
  objareasempresa.eliminar_areasempresa(req, res)
})

// actualizar
rooutes.put('/:id_areempre', async (req, res) => {
  objareasempresa.actualise_areasempresa(req, res)
})

module.exports = rooutes
