const express = require('express')
const rooutes = express.Router()
const NegvaloriActivDim = require('../../negocio/v2/valoriActivDim.negocio')
const objvaloriActivDim = new NegvaloriActivDim()
// ######################### rooutes ###################################

// Listar
rooutes.get('/:id_valorActiv', async (req, res) => {
  objvaloriActivDim.list_valoriActivDimen(req, res)
})

// insertar
rooutes.post('/', async (req, res) => {
  objvaloriActivDim.inser_valoriActivDimen(req, res)
})

// eliminar
rooutes.delete('/:id_valorActiDimen', async (req, res) => {
  objvaloriActivDim.eliminar_valoriActivDimen(req, res)
})

// actualizar
// rooutes.put('/infoCuenta/:id_clienAnalit', async (req, res) => {
//   objclienAnalit.actuali_clienAnalitInfoUser(req, res)
// })

module.exports = rooutes
