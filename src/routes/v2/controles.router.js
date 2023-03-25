const express = require('express')
const rooutes = express.Router()
const Negcontroles = require('../../negocio/v2/controles.negocio')
const objcontroles = new Negcontroles()
// ######################### rooutes ###################################

// List
rooutes.get('/:id_classControl', async (req, res) => {
  objcontroles.list_controles(req, res)
})

// insertar
rooutes.post('/', async (req, res) => {
  objcontroles.inser_controles(req, res)
})

// delete
// rooutes.delete('/:id_areaProce', async (req, res) => {
//   objareainterproce.eliminar_areainterproce(req, res)
// })

module.exports = rooutes
