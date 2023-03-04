const express = require('express')
const rooutes = express.Router()
// --------------------------------
const Negmessegconten = require('../negocio/messecontac.negocio')
const objnegmessegconten = new Negmessegconten()
// ######################### rooutes ###################################
// listar
rooutes.post('/', async (req, res) => {
  // let results = await conexibd.single_query(req, res,'CALL `list_coment_canv`();',[]);
  // return res.send((Array.isArray(results))?results:[]);
  objnegmessegconten.enviarcorreocontact(req, res)
})

module.exports = rooutes
