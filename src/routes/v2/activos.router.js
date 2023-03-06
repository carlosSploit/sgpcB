const express = require('express')
const rooutes = express.Router()
const Negactivos = require('../../negocio/v2/activos.negocio')
const objactivos = new Negactivos()
// ######################### rooutes ###################################

// List
rooutes.get('/:id_empresa', async (req, res) => {
  objactivos.list_activos(req, res)
})

// insertar
rooutes.post('/', async (req, res) => {
  objactivos.inser_activo(req, res)
})

// delete
rooutes.delete('/:id_activo', async (req, res) => {
  objactivos.eliminar_activos(req, res)
})

// actualizar
rooutes.put('/:id_activo', async (req, res) => {
  objactivos.actualise_activos(req, res)
})

module.exports = rooutes
