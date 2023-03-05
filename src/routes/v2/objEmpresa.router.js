const express = require('express')
const rooutes = express.Router()
const Negobjempresa = require('../../negocio/v2/objEmpresa.negocio')
const odjobjempresa = new Negobjempresa()
// ######################### rooutes ###################################

// List
rooutes.get('/:id_empresa', async (req, res) => {
  odjobjempresa.list_objempresa(req, res)
})

// insertar
rooutes.post('/', async (req, res) => {
  odjobjempresa.inser_objempresa(req, res)
})

// delete
rooutes.delete('/:id_objEmpresa', async (req, res) => {
  odjobjempresa.eliminar_objempresa(req, res)
})

// actualizar
rooutes.put('/:id_objEmpresa', async (req, res) => {
  odjobjempresa.actualise_objempresa(req, res)
})

module.exports = rooutes
