const express = require('express')
const rooutes = express.Router()
const Negresponanalis = require('../../negocio/v2/responanalis.negocio')
const objresponanalis = new Negresponanalis()
// ######################### rooutes ###################################

// List
rooutes.get('/:id_versionAnali', async (req, res) => {
  objresponanalis.list_responanalis(req, res)
})

// insertar
rooutes.post('/', async (req, res) => {
  objresponanalis.insert_responanalis(req, res)
})

// delete
// rooutes.delete('/:id_resposProce', async (req, res) => {
//   objresponanalis.eliminar_resposproce(req, res)
// })

module.exports = rooutes
