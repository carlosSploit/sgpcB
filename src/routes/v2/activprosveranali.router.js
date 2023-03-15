const express = require('express')
const rooutes = express.Router()
const Negactivprocesanali = require('../../negocio/v2/activprocesanali.negocio')
const objactivprocesanali = new Negactivprocesanali()
// ######################### rooutes ###################################

// List
rooutes.get('/:id_versonAnali', async (req, res) => {
  objactivprocesanali.list_activprosveranali(req, res)
})

// Read
rooutes.get('/read/:id_activProsVerAnali', async (req, res) => {
  objactivprocesanali.read_activprosveranali(req, res)
})

// insertar
rooutes.post('/', async (req, res) => {
  objactivprocesanali.insert_activprosveranali(req, res)
})

// delete
rooutes.delete('/:id_activProsVerAnali', async (req, res) => {
  objactivprocesanali.eliminar_activprosveranali(req, res)
})

module.exports = rooutes
