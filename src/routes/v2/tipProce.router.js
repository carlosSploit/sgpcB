const express = require('express')
const rooutes = express.Router()
const NegtipProce = require('../../negocio/v2/tipProce.negocio')
const odjtipProce = new NegtipProce()
// ######################### rooutes ###################################

// List
rooutes.get('/', async (req, res) => {
  odjtipProce.list_tipProce(req, res)
})

module.exports = rooutes
