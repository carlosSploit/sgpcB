const express = require('express')
const rooutes = express.Router()
const Neggerarproc = require('../../negocio/v2/gerarproc.negocio')
const odjgerarproc = new Neggerarproc()
// ######################### rooutes ###################################

// List
rooutes.get('/', async (req, res) => {
  odjgerarproc.list_gerarProce(req, res)
})

module.exports = rooutes
