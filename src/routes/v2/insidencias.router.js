const express = require('express')
const rooutes = express.Router()
const Neginsidencias = require('../../negocio/v2/insidencias.negocio')
const objinsidencias = new Neginsidencias()
// ######################### rooutes ###################################

// List
rooutes.get('/:id_proceso', async (req, res) => {
  objinsidencias.list_insidencias(req, res)
})

// insertar
rooutes.post('/', async (req, res) => {
  objinsidencias.inser_insidencia(req, res)
})

// delete
rooutes.delete('/:id_insidencia', async (req, res) => {
  objinsidencias.eliminar_insidencias(req, res)
})

// actualizar
rooutes.put('/:id_insidencia', async (req, res) => {
  objinsidencias.actualise_insidencias(req, res)
})

module.exports = rooutes
