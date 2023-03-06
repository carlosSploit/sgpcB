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
// rooutes.delete('/:id_areempre', async (req, res) => {
//   objareasempresa.eliminar_areasempresa(req, res)
// })

// actualizar
// rooutes.put('/:id_areempre', async (req, res) => {
//   objareasempresa.actualise_areasempresa(req, res)
// })

module.exports = rooutes
