const express = require('express')
const rooutes = express.Router()
const Negclasscontroles = require('../../negocio/v2/classcontroles.negocio')
const objclasscontroles = new Negclasscontroles()
// ######################### rooutes ###################################

// List
rooutes.get('/', async (req, res) => {
  objclasscontroles.list_classcontrol(req, res)
})

// insertar
rooutes.post('/', async (req, res) => {
  objclasscontroles.inser_classcontrol(req, res)
})

// delete
// rooutes.delete('/:id_areaProce', async (req, res) => {
//   objareainterproce.eliminar_areainterproce(req, res)
// })

module.exports = rooutes
