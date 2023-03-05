const express = require('express')
const rooutes = express.Router()
/// ------------------------------------------------------------------------------ callbacks/ triggers
// const skgenerick = require('./sockets/generic.socket')
// const skusuario = require('./sockets/usuarios.socket')
// const sktipocurso = require('./sockets/tipocurso.socket')
/// ------------------------------------------------------------------------------ rotas de app
const verifyToken = require('../config/tockenizer/tokenizer')
const tokeniser = require('../config/tockenizer/router/routertoken')
// const generico = require('./routes/generic.router')
// const messecontac = require('./routes/messecontac.router')
// const admin = require('./routes/admin.router')
// const profes = require('./routes/profesor.router')
const usuario = require('./routes/v2/usuarios.router')
const clientAnalit = require('./routes/v2/clienteAnalist.router')
const empresa = require('./routes/v2/empresa.router')
// const alumno = require('./routes/alumno.router')
// const tutalum = require('./routes/tutAlum.router')
// const tipocurso = require('./routes/tipocurso.router')
// const sesion = require('./routes/sesion.router')
// const curso = require('./routes/curso.router')
// const ciclocurso = require('./routes/ciclocurso.router')
// const inscrip = require('./routes/inscripccion.router')
// const contsesin = require('./routes/contsesion.router')
// const contactv = require('./routes/contactiv.router')
// const tipocontses = require('./routes/tipcontsesion.router')
// const tareainscr = require('./routes/tareainscr.router')
// const asistenc = require('./routes/asistencia.router')
// const analitic = require('./routes/analiticas.router')
// const pointclass = require('./routes/puntosclass.router')
// const insertpuntclas = require('./routes/inscrpointclas.router')
// ftp midelware
const ftpgoogle = require('../config/ftp/googledrive/cloudgoogle')
const ftpclodyn = require('../config/ftp/cloudinary/uploudcloud')

// --------------------------------------------------------------------------------- ROUTER EXPRESS
// api de tokenizer
rooutes.use('/tokeniser', tokeniser)
// --------------------------------------------------------------------------------- ejecucion de router
// rooutes.use('/messecontac', messecontac)
rooutes.use('/usuar', usuario)
rooutes.use('/clientAnalit', clientAnalit)
rooutes.use('/empresa', empresa)
// rooutes.use('/admi', verifyToken, admin)
// rooutes.use('/profe', verifyToken, profes)
// rooutes.use('/alumn', alumno)
// rooutes.use('/tutalm', tutalum)
// rooutes.use('/tipocur', verifyToken, tipocurso)
// rooutes.use('/sesion', sesion)
// rooutes.use('/curso', verifyToken, curso)
// rooutes.use('/cicurs', ciclocurso)
// rooutes.use('/inscri', verifyToken, inscrip)
// rooutes.use('/contses', verifyToken, contsesin)
// rooutes.use('/contactv', verifyToken, contactv)
// rooutes.use('/tipcontses', verifyToken, tipocontses)
// rooutes.use('/tarinsc', verifyToken, tareainscr)
// rooutes.use('/asisten', verifyToken, asistenc)
// rooutes.use('/anli', verifyToken, analitic)
// rooutes.use('/pointcl', verifyToken, pointclass)
// rooutes.use('/inspuntclas', verifyToken, insertpuntclas)
// router ftp
rooutes.use('/ftpgoogle', ftpgoogle) // subir archivos
rooutes.use('/ftpclodyn', verifyToken, ftpclodyn) // subir archivos

// --------------------------------------------------------------------------------- SOCKET IO
// const SocketIo = (socket) => {
//   skgenerick(socket)
//   skusuario(socket)
//   sktipocurso(socket)
// }

module.exports = {
  rooutes
  // ,SocketIo
}
