const express = require('express')
const rooutes = express.Router()
const { v4 } = require('uuid')
// ######################### rooutes ###################################
// listar
rooutes.get('/', async (req, res) => {
  console.log(v4())
  return res.send('Probando la ruta generica')
})

module.exports = rooutes
