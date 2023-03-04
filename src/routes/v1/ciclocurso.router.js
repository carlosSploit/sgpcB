const express = require('express')
const rooutes = express.Router()
const Negciclocurso = require('../negocio/ciclocurso.negocio')
const objciclocurso = new Negciclocurso()
// ######################### rooutes ###################################
// listar
rooutes.get('/', async (req, res) => {
  objciclocurso.list_admin(req, res)
})
// listar cursos
rooutes.get('/listcurso/:name', async (req, res) => {
  objciclocurso.list_ciclocurs_to_listcourse(req, res)
})

// listar ciclos por curso
rooutes.get('/listciclocurso/:id_curso', async (req, res) => {
  objciclocurso.list_ciclocurso_to_course(req, res)
})

// read
rooutes.get('/read/:id_curso', async (req, res) => {
  objciclocurso.read_ciclocurso(req, res)
})

// delect
rooutes.delete('/:idciclocur', async (req, res) => {
  objciclocurso.delect_ciclocurso(req, res)
})

// insertar
rooutes.post('/', async (req, res) => {
  objciclocurso.inser_ciclocurso(req, res)
})

// actualizar
rooutes.put('/:idciclocur', async (req, res) => {
  objciclocurso.actuali_ciclocurso(req, res)
})

module.exports = rooutes
