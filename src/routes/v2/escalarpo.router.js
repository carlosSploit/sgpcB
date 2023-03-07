const express = require('express')
const rooutes = express.Router()
const Negescalarpo = require('../../negocio/v2/escalarpo.negocio')
const odjescalarpo = new Negescalarpo()
// ######################### rooutes ###################################

// List
rooutes.get('/', async (req, res) => {
  odjescalarpo.list_escalarpo(req, res)
})

module.exports = rooutes
