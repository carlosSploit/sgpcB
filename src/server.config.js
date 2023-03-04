const express = require('express')
const path = require('path')
// const http = require('http')
// const { Server } = require('socket.io')
/// rotas de app ---------------------------------
const apiRv2 = require('./index.routers')
// const apiSv2 = require('./index.socket')
/// ----------------------------------------------
const config = require('../config/config.js')
const middelware = require('../config/myddelwares')
const smtpgmail = require('../config/smtp/nodemulter/nodemulter')
// config ----------------------------------------------------------------------
const app = express()
// const serverApp = http.createServer(app) // crea un nuevo servicio para el socket io
// const ioSocket = new Server(serverApp, { cors: { origin: '*' } }) // creando escucha de web socket
// configura que se envie como header el proxy del usuario
// app.enable('trust proxy')
// app.set("trust proxy", true);
// || config.apires.portpru
app.set('port', process.env.PORT || config.apires.portpru)
app.set('views', path.join(__dirname, 'views'))
app.set('view engine', 'ejs')
//  mydellwares ------------------------------------------------------------------
/*
si se desea utilizar mysql desmessecontace la linea
app.use(middelware.configmysql)
por otro lado entre a la carpeta config/lib/myddelware.js y resmessecontace la linea
configmysql: mysqlconnet(mysql, dbopccion, config.bd.mysql.tipeOption),
*/
app.use(middelware.configmysql)
app.use(middelware.configjson)
app.use(middelware.configresponse)
app.use(middelware.configcorsdev) // configuracion de los cors
// rootas -----------------------------------------------------------------------
//* *** roota principal o gemerica *****/
app.get('/', (req, res) => {
  const list = [1]
  let vasin
  console.log(typeof (vasin + ''))
  // console.log(list.length != 0)
  console.log(list.length !== 0)
  res.send(`welcon to my apy ${req.ip}`)
})

app.get('/gmail', (req, res) => {
  smtpgmail()
  res.send('enviado correctamente')
})
//* *** routers personalizados - ,verifyToken, */
app.use('/api2', apiRv2.rooutes)
// controll de erroresº
app.use(middelware.midellerror)

// Server Socket-----------------------------------------------------------------
// ioSocket.on('connection', (socket) => {
//   apiv2.SocketIo(socket)
// })
module.exports = app
