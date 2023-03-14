const express = require('express')
const rooutes = express.Router()
const NegvaloriActiv = require('../../negocio/v2/valoriActiv.negocio')
const objvaloriActiv = new NegvaloriActiv()
// ######################### rooutes ###################################

// read
rooutes.get('/read/:id_activProsVerAnali', async (req, res) => {
  objvaloriActiv.list_valoractiv(req, res)
})

// insertar
rooutes.post('/', async (req, res) => {
  objvaloriActiv.inser_valoriActiv(req, res)
})

// actualizar
rooutes.put('/:id_valorActiv', async (req, res) => {
  objvaloriActiv.actualizar_valoractiv(req, res)
})

// actualizar
// rooutes.put('/infoCuenta/:id_clienAnalit', async (req, res) => {
//   objclienAnalit.actuali_clienAnalitInfoUser(req, res)
// })

module.exports = rooutes
