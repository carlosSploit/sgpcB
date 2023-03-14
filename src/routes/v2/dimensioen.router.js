const express = require('express')
const rooutes = express.Router()
const Negdimensioen = require('../../negocio/v2/dimensioen.negocio')
const objdimensioen = new Negdimensioen()
// ######################### rooutes ###################################

// List
rooutes.get('/', async (req, res) => {
  objdimensioen.list_dimensionanalisis(req, res)
})

// insertar
rooutes.post('/', async (req, res) => {
  objdimensioen.inser_dimensionanalisis(req, res)
})

// delete
// rooutes.delete('/:id_areaProce', async (req, res) => {
//   objareainterproce.eliminar_areainterproce(req, res)
// })

module.exports = rooutes
