const express = require('express')
const rooutes = express.Router()
const NegobjVersioAnalis = require('../../negocio/v2/objVersioAnalis.negocio')
const objVersioAnalis = new NegobjVersioAnalis()
// ######################### rooutes ###################################

// List
rooutes.get('/:id_empresa', async (req, res) => {
  objVersioAnalis.list_objVersioAnalis(req, res)
})

// insertar
rooutes.post('/', async (req, res) => {
  objVersioAnalis.inser_objVersioAnalis(req, res)
})

// delete
rooutes.delete('/:id_objEmpresa', async (req, res) => {
  objVersioAnalis.eliminar_objempresa(req, res)
})

// actualizar
rooutes.put('/:id_objEmpresa', async (req, res) => {
  objVersioAnalis.actualise_objempresa(req, res)
})

module.exports = rooutes
