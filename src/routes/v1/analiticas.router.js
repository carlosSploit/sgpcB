const express = require('express')
const rooutes = express.Router()
const Negadmin = require('../negocio/analiticas.negocio')
const objadmin = new Negadmin()
// ######################### rooutes ###################################
// listar
rooutes.get('/cicl/sincrono/:idcurso', async (req, res) => {
  objadmin.list_analiticas_ciclo_sincrono(req, res)
})

// listar
rooutes.get('/cicl/sincrono/puntos/:idcurso', async (req, res) => {
  objadmin.list_analiticas_ciclo_sincrono_puntos(req, res)
})

module.exports = rooutes
