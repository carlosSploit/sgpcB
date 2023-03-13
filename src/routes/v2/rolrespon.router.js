const express = require('express')
const rooutes = express.Router()
const Negrolrespon = require('../../negocio/v2/rolrespon.negocio')
const odjrolrespon = new Negrolrespon()
// ######################### rooutes ###################################

// List
rooutes.get('/', async (req, res) => {
  odjrolrespon.list_rolrespon(req, res)
})

module.exports = rooutes
