const express = require('express')
const rooutes = express.Router()
const jwt = require('jsonwebtoken')
const config = require('../../config.js')

// **** atentificacion *****/
rooutes.use('/', (req, res) => {
  const user = config.apidatkey
  jwt.sign({ user }, 'secretkey', (erro, token) => {
    res.json({
      token
    })
  })
})

module.exports = rooutes
