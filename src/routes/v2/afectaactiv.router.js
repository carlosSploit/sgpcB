const express = require('express')
const rooutes = express.Router()
const Negafectaactiv = require('../../negocio/v2/afectaactiv.negocio')
const objafectaactiv = new Negafectaactiv()
// ######################### rooutes ###################################

// List
rooutes.get('/:id_activProsVerAnali', async (req, res) => {
  objafectaactiv.list_afectaactiv(req, res)
})

// Read
// rooutes.get('/read/:id_activProsVerAnali', async (req, res) => {
//   objactivprocesanali.read_activprosveranali(req, res)
// })

// generar amenazas
rooutes.post('/generar/', async (req, res) => {
  objafectaactiv.cargarAmenazas(req, res)
})

// insertar de forma manual una amenazas
rooutes.post('/', async (req, res) => {
  objafectaactiv.inser_afectaactiv(req, res)
})

// actualizar el esenario de la amenaza
rooutes.put('/:id_afectaActiv', async (req, res) => {
  objafectaactiv.actualizar_afectaactiv(req, res)
})

// delete
rooutes.delete('/:id_afectaActiv', async (req, res) => {
  objafectaactiv.delete_afectaactiv(req, res)
})

module.exports = rooutes
