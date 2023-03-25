const express = require('express')
const rooutes = express.Router()
const NegvaloriAmenas = require('../../negocio/v2/valoriAmenas.negocio')
const objvaloriAmenas = new NegvaloriAmenas()
// ######################### rooutes ###################################

// read
rooutes.get('/:id_afectaActiv', async (req, res) => {
  objvaloriAmenas.list_valorafectamen(req, res)
})

// insertar
rooutes.post('/', async (req, res) => {
  objvaloriAmenas.insert_valorafectamen(req, res)
})

// comprobar
rooutes.post('/comprobar/', async (req, res) => {
  objvaloriAmenas.compruebeExistenValori(req, res)
})

// actualizar
rooutes.put('/:id_valorAfectAmen', async (req, res) => {
  objvaloriAmenas.actualizar_valorafectamen(req, res)
})

// actualizar
// rooutes.put('/infoCuenta/:id_clienAnalit', async (req, res) => {
//   objclienAnalit.actuali_clienAnalitInfoUser(req, res)
// })

module.exports = rooutes
