const express = require('express')
const rooutes = express.Router()
const NegplanesContingencia = require('../../negocio/v2/planesContingencia.negocio')
const objplanesContingencia = new NegplanesContingencia()
// ######################### rooutes ###################################

// List
rooutes.get('/inforproces/:id_versionAnalitic', async (req, res) => {
  objplanesContingencia.informationProces(req, res)
})

rooutes.get('/inforamenaz/:id_activProsVerAnali/:id_afectaActiv', async (req, res) => {
  objplanesContingencia.imformationAmenaz(req, res)
})

// // insertar
// rooutes.post('/', async (req, res) => {
//   objactivos.inser_activo(req, res)
// })

// // delete
// rooutes.delete('/:id_activo', async (req, res) => {
//   objactivos.eliminar_activos(req, res)
// })

// // actualizar
// rooutes.put('/:id_activo', async (req, res) => {
//   objactivos.actualise_activos(req, res)
// })

module.exports = rooutes
