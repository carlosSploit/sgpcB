const express = require('express')
const rooutes = express.Router()
const Ngtipocontesession = require('../negocio/tipocontesession.negocio')
const objtipocontesession = new Ngtipocontesession()
// ######################### rooutes ###################################
// listar
rooutes.get('/', async (req, res) => {
  objtipocontesession.list_tipoconte(req, res)
})

module.exports = rooutes
