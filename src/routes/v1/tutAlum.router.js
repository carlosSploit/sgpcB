const express = require('express')
const rooutes = express.Router()
const NegtutAlum = require('../negocio/tutAlum.negocio')
const objtutAlum = new NegtutAlum()
// ######################### rooutes ###################################
// listar
rooutes.get('/', async (req, res) => {
  objtutAlum.list_tutalum(req, res)
})
// //listar
// rooutes.get('/:name', async (req, res) => {
//     objtutAlum.list_alumno(req, res);
// })

// //listar
// rooutes.get('/read/:id_alumno', async (req, res) => {
//     objtutAlum.read_alumno(req, res);
// })

// //delect
// rooutes.delete('/:id_alumno', async (req, res) => {
//     objtutAlum.delect_alumno(req, res);
// })

// insertar
rooutes.post('/', async (req, res) => {
  objtutAlum.inser_alumno(req, res)
})

// //actualizar
// rooutes.put('/:id_alumno', async (req, res) => {
//     objtutAlum.actuali_alumno(req, res);
// })

module.exports = rooutes
