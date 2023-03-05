// const verifyToken = require('../../config/tockenizer/tokenizer')
const express = require('express')
const rooutes = express.Router()
const Negusuario = require('../../negocio/v2/usuario.negocio')
const objusuario = new Negusuario()
// ######################### rooutes ###################################

// comprobe useer
// rooutes.post('/compuser', async (req, res) => {
//   objusuario.compro_logusser(req, res)
// })

// comprobe data de usser
rooutes.post('/compDatalog', async (req, res) => {
  objusuario.read_loginInfoUser(req, res)
})

// insertar log del inicio de secion
rooutes.post('/loginUser', async (req, res) => {
  await objusuario.loginUser(req, res)
})

// retornar la key api
rooutes.post('/keyApiSession', async (req, res) => {
  objusuario.read_loginApiKey(req, res)
})

module.exports = rooutes
