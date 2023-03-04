const express = require('express')
const rooutes = express.Router()
const Negalumno = require('../negocio/alumno.negocio')
const objalumno = new Negalumno()
// ######################### rooutes ###################################
// listar
rooutes.get('/', async (req, res) => {
  objalumno.list_alumno(req, res)
})
// listar
rooutes.get('/:name', async (req, res) => {
  objalumno.list_alumno(req, res)
})

// listar
rooutes.get('/read/:id_alumno', async (req, res) => {
  objalumno.read_alumno(req, res)
})

// delect
rooutes.delete('/:id_alumno', async (req, res) => {
  objalumno.delect_alumno(req, res)
})

// insertar
rooutes.post('/', async (req, res) => {
  objalumno.inser_alumno(req, res)
})

// actualizar
rooutes.put('/:id_alumno', async (req, res) => {
  objalumno.actuali_alumno(req, res)
})

module.exports = rooutes
