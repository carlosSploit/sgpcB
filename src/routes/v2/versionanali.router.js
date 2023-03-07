const express = require('express')
const rooutes = express.Router()
const Negversionanali = require('../../negocio/v2/versionanali.negocio')
const objversionanali = new Negversionanali()
// ######################### rooutes ###################################

// List
rooutes.get('/:id_proceso', async (req, res) => {
  objversionanali.list_versionanali(req, res)
})

// insertar
rooutes.post('/', async (req, res) => {
  objversionanali.inser_versionanali(req, res)
})

// delete
// rooutes.delete('/:id_areaProce', async (req, res) => {
//   objareainterproce.eliminar_areainterproce(req, res)
// })

module.exports = rooutes
