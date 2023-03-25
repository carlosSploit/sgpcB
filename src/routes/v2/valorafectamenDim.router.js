const express = require('express')
const rooutes = express.Router()
const NegvalorafectamenDim = require('../../negocio/v2/valoriAmenasDim.negocio')
const objvalorafectamenDim = new NegvalorafectamenDim()
// ######################### rooutes ###################################

// read
rooutes.get('/:id_valorAfectAmen', async (req, res) => {
  objvalorafectamenDim.list_valAfectAmenDimen(req, res)
})

// insertar
rooutes.post('/', async (req, res) => {
  objvalorafectamenDim.ValorizarAmenazasDegrad(req, res)
})

// compruebe
rooutes.post('/compruebe/', async (req, res) => {
  objvalorafectamenDim.compruebeExistenValori(req, res)
})

// List Dimension Data
rooutes.get('/listDimension/:id_valorAfectAmen', async (req, res) => {
  req.body.id_valorAfectAmen = req.params.id_valorAfectAmen
  const result = await objvalorafectamenDim.extracDimensionAmenaza(req, res)
  res.send(result)
})

// Cargar la valorizacion de manera generalizada
rooutes.post('/cargRiesgo/', async (req, res) => {
  const result = await objvalorafectamenDim.cargar_valorizacionRiesgo(req, res)
  res.send(result)
})

// actualizar
// rooutes.put('/infoCuenta/:id_clienAnalit', async (req, res) => {
//   objclienAnalit.actuali_clienAnalitInfoUser(req, res)
// })

module.exports = rooutes
