const express = require('express')
const rooutes = express.Router()
const NegdepenActivArbol = require('../../negocio/v2/depenActivArbol.negocio')
const objdepenActivArbol = new NegdepenActivArbol()
// ######################### rooutes ###################################

// List
rooutes.get('/:id_tipoActiv', async (req, res) => {
  objdepenActivArbol.list_depenActivArbol(req, res)
})

// Dependencia de una abrebiatura con otras abrebiaturas
rooutes.get('/:id_proceso/:abrebiat', async (req, res) => {
  objdepenActivArbol.get_dependenofabreb(req, res)
})

// insertar
rooutes.post('/', async (req, res) => {
  objdepenActivArbol.inser_depenActivArbol(req, res)
})

// delete
// rooutes.delete('/:id_areaProce', async (req, res) => {
//   objareainterproce.eliminar_areainterproce(req, res)
// })

module.exports = rooutes
