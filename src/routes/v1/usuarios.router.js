// const verifyToken = require('../../config/tockenizer/tokenizer')
const express = require('express')
const rooutes = express.Router()
const Negusuario = require('../negocio/usuario.negocio')
const objusuario = new Negusuario()
// ######################### rooutes ###################################

// comprobe useer
rooutes.post('/complog', async (req, res) => {
  objusuario.compro_logusser(req, res)
})

// comprobe data de usser
rooutes.post('/compdatalog', async (req, res) => {
  objusuario.compru_datasecion(req, res)
})

// comprobe la recuperar la contraseña
rooutes.post('/comprespass', async (req, res) => {
  objusuario.compru_recpass(req, res)
})

// insertar log del inicio de secion
rooutes.post('/insinglog', async (req, res) => {
  objusuario.insert_singlog(req, res)
})

// retornar la key api
rooutes.post('/apiac', async (req, res) => {
  objusuario.compru_api_key(req, res)
})

module.exports = rooutes
