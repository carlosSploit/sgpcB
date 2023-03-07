const express = require('express')
const rooutes = express.Router()
const Negescalarto = require('../../negocio/v2/escalarto.negocio')
const odjescalarto = new Negescalarto()
// ######################### rooutes ###################################

// List
rooutes.get('/', async (req, res) => {
  odjescalarto.list_escalarto(req, res)
})

module.exports = rooutes
