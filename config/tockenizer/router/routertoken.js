const express = require('express')
const rooutes = express.Router()
const jwt = require('jsonwebtoken')
const config = require('../../config.js')

// **** atentificacion *****/
rooutes.use('/', (req, res) => {
  const user = config.apidatkey
  const token = jwt.sign({ user }, 'secretkey')
  res.json({ token: token })
})

module.exports = rooutes
