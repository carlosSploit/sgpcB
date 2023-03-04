/// callbacks/ triggers --------------------------
const skgenerick = require('./sockets/generic.socket')
const skusuario = require('./sockets/usuarios.socket')
const sktipocurso = require('./sockets/tipocurso.socket')

// --------------------------------------------------------------------------------- SOCKET IO
const SocketIo = (socket) => {
  skgenerick(socket)
  skusuario(socket)
  sktipocurso(socket)
}

module.exports = {
  SocketIo
}
