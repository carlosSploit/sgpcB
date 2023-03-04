const express = require('express')
const rooutes = express.Router()
const Ngtareainsc = require('../negocio/tareainsc.negocio')
const objtareainsc = new Ngtareainsc()
// ######################### rooutes ###################################
// listar
rooutes.get('/:id_conttar', async (req, res) => {
  objtareainsc.list_tareainscr(req, res)
})

// listar ranking point inscrip
rooutes.get('/pointrank/:id_ciclocur', async (req, res) => {
  objtareainsc.list_tareainscr_ranking(req, res)
})

// delect
rooutes.delete('/:id_tareinsc', async (req, res) => {
  objtareainsc.delect_tareainscr(req, res)
})

// insertar
rooutes.post('/', async (req, res) => {
  objtareainsc.insert_tareainscr(req, res)
})

// actualizar
rooutes.put('/:id_tarins', async (req, res) => {
  objtareainsc.actualise_tareainsc(req, res)
})

// actualizar puntos
rooutes.put('/point/:id_tarins', async (req, res) => {
  objtareainsc.actualise_tareainsc_to_point(req, res)
})

module.exports = rooutes
