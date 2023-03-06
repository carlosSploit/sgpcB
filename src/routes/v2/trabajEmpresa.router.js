const express = require('express')
const rooutes = express.Router()
const NegtrabEmpresa = require('../../negocio/v2/trabEmpresa.negocio')
const objtrabEmpresa = new NegtrabEmpresa()
// ######################### rooutes ###################################

// List
rooutes.get('/:id_empresa', async (req, res) => {
  objtrabEmpresa.list_trabEmpresa(req, res)
})

// insertar
rooutes.post('/', async (req, res) => {
  objtrabEmpresa.inser_trabajempresa(req, res)
})

// delete
rooutes.delete('/:id_areempre', async (req, res) => {
  objtrabEmpresa.eliminar_areasempresa(req, res)
})

// actualizar
rooutes.put('/:id_areempre', async (req, res) => {
  objtrabEmpresa.actualise_areasempresa(req, res)
})

module.exports = rooutes
