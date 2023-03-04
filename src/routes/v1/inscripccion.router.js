const express = require('express')
const rooutes = express.Router()
const Neginscripc = require('../negocio/inscripc.negocio')
const objinscripc = new Neginscripc()
// ######################### rooutes ###################################
// listar
rooutes.get('/', async (req, res) => {
  objinscripc.list_admin(req, res)
})
// listar pre inscripcciones en espera
rooutes.get('/list/preinscr/', async (req, res) => {
  objinscripc.list_preinscrip(req, res)
})

// listar cursos inscritos por alumno
rooutes.get('/list/inscrtocouse/:id_alumn', async (req, res) => {
  objinscripc.list_inscrip_to_curso_alumno(req, res)
})

// listar cursos inscritos/alumno
rooutes.get('/list/inscralumno/:id_ciclcurs', async (req, res) => {
  objinscripc.list_inscrip_the_alumno(req, res)
})

// validar el alumno y el ciclo de curso
rooutes.post('/valalumnocurs/', async (req, res) => {
  objinscripc.valider_inscricurse(req, res)
})

// read
rooutes.get('/read/:id_curso', async (req, res) => {
  objinscripc.read_ciclocurso(req, res)
})

// delect
rooutes.delete('/:idciclocur', async (req, res) => {
  objinscripc.delect_ciclocurso(req, res)
})

// insertar
rooutes.post('/', async (req, res) => {
  objinscripc.insert_inscrip(req, res)
})

// insertar
rooutes.post('/getidinscrip/', async (req, res) => {
  objinscripc.read_idinscrit_for_idconttar_and_idalumn(req, res)
})

// actualizar estado de la inscripccion
rooutes.put('/actstade/:idinscrip', async (req, res) => {
  objinscripc.actualise_stado_inscrip(req, res)
})

module.exports = rooutes
