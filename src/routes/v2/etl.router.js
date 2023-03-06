const express = require('express')
const rooutes = express.Router()
const ETLtipoActiv = require('../../ETL/tipoActiv.etl')
const objtipoActiv = new ETLtipoActiv()
// ######################### rooutes ###################################

// List
rooutes.get('/tipoActiv', async (req, res) => {
  const result = await objtipoActiv.formatMYSQL()
  console.log(result)
})

// // insertar
// rooutes.post('/', async (req, res) => {
//   objareainterproce.inser_areainterproce(req, res)
// })

// // delete
// rooutes.delete('/:id_areaProce', async (req, res) => {
//   objareainterproce.eliminar_areainterproce(req, res)
// })

module.exports = rooutes
