const express = require('express')
const rooutes = express.Router()
const Nginscrpointclas = require('../negocio/inscrpointclas.negocio')
const objadmin = new Nginscrpointclas()
// ######################### rooutes ###################################
rooutes.get('/:tiposes/:id_tiposes/:id_inscri', async (req, res) => {
  objadmin.list_inscpointclas(req, res)
})

// delect
// rooutes.delete('/:id_puntosclass', async (req, res) => {
//     objadmin.delect_puntosclass(req, res);
// })

// insertar
rooutes.post('/', async (req, res) => {
  objadmin.inser_inscrpointclas(req, res)
})

// validar un punto
rooutes.post('/valit', async (req, res) => {
  objadmin.valider_inscpointclas(req, res)
})

// eliminar un punto de clase en inscripccion
rooutes.post('/delet', async (req, res) => {
  objadmin.delect_inscripuntclas(req, res)
})

// actualizar
// rooutes.put('/:id_puntosclass', async (req, res) => {
//     objadmin.actuali_pointclass(req, res);
// })

module.exports = rooutes
