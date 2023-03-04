const express = require('express')
const rooutes = express.Router()
const Negcurso = require('../negocio/curso.negocio')
const objcurso = new Negcurso()
// ######################### rooutes ###################################
// listar
// rooutes.get('/', async (req, res) => {
//     objcurso.list_admin(req, res);
// })
// listar
rooutes.get('/:name', async (req, res) => {
  objcurso.list_curso(req, res)
})
// listar
// rooutes.get('/read/:id_admin', async (req, res) => {
//     objcurso.read_admin(req, res);
// })

// delect
rooutes.delete('/:idcurso', async (req, res) => {
  objcurso.delect_curso(req, res)
})

// insertar
rooutes.post('/', async (req, res) => {
  objcurso.inser_curso(req, res)
})

// actualizar
rooutes.put('/:idcurso', async (req, res) => {
  objcurso.actuali_curso(req, res)
})

module.exports = rooutes
