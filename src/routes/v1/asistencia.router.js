const express = require('express')
const rooutes = express.Router()
const Negasistencia = require('../negocio/asistencia.negocio')
const objasistencia = new Negasistencia()
// ######################### rooutes ###################################

// listar
rooutes.get('/list/aperture/:id_ciclo', async (req, res) => {
  objasistencia.list_apertureasistencia(req, res)
})

// listar
rooutes.get('/list/inscrip/:id_asisapert', async (req, res) => {
  objasistencia.list_inscripasisten(req, res)
})

// delect
rooutes.delete('/:id_sesion', async (req, res) => {
  objasistencia.delect_asistencia(req, res)
})

// insertar
rooutes.post('/', async (req, res) => {
  objasistencia.inser_apertureasistencia(req, res)
})

// actualizar
rooutes.put('/:id_asisinscr', async (req, res) => {
  objasistencia.actuali_stadoasisten(req, res)
})

module.exports = rooutes
