const express = require('express')
const rooutes = express.Router()
const Negversionanali = require('../../negocio/v2/versionanali.negocio')
const objversionanali = new Negversionanali()
// ######################### rooutes ###################################

// List
rooutes.get('/:id_proceso', async (req, res) => {
  const result = await objversionanali.list_versionanali(req, res)
  res.json(result)
})

// insertar
rooutes.post('/', async (req, res) => {
  objversionanali.inser_versionanali(req, res)
})

// delete
rooutes.delete('/:id_versionAnali', async (req, res) => {
  objversionanali.eliminar_versionanali(req, res)
})

module.exports = rooutes
