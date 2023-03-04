// si se desea utilizar mysql desabilita esto
const mysql = require('mysql');
const mysqlconnet = require('express-myconnection');
const config = require('./config.js');
const express = require('express');
const morgan = require('morgan');
const cors = require("cors");
const midellerror = require("./error/midellerror");
// configuraciones
const dbopccion = config.bd.mysql[config.bd.mysql.tipeOption]

function getIPAddress() {
    var interfaces = require('os').networkInterfaces();
    for (var devName in interfaces) {
      var iface = interfaces[devName];
  
      for (var i = 0; i < iface.length; i++) {
        var alias = iface[i];
        if (alias.family === 'IPv4' && alias.address !== '127.0.0.1' && !alias.internal)
          return alias.address;
      }
    }
  
    return '0.0.0.0';
}

const cors_product = (req , callback)=>{
    let whitelist = config.apires.control_access.origin
    let methodssuport = config.apires.control_access.methods
    // comprueba si el dominio es compatible
    let corsOptions = (whitelist.indexOf(req.header('Origin')) !== -1)? { origin: true } : { origin: false }
    // comprueba si el methodo esta permitido
    let corsOptions2 = (methodssuport.indexOf(req.method) !== -1)? { origin: true } : { origin: false }
    // console.log(req.header('Origin'))
    callback(null, {origin: (corsOptions.origin && corsOptions2.origin)})
};

const cors_dev = (req , callback)=>{
    let corsOptions = {origin: true};
    // console.log(req.headers);
    // console.log("#");
    // console.log(req.socket.remoteAddress);
    // console.log(req.ip);
    // console.log(req.header('x-forwarded-for'));
    // console.log(req.header('Origin'));
    // console.log(req.header('User-Agent'));
    // console.log("------------------------------------------------")
    callback(null, {origin: true})
};


module.exports = {
    configmysql: mysqlconnet(mysql, dbopccion, config.bd.mysql.tipeOption),
    getIPAddress : getIPAddress,
    configjson : express.json(), // para que las respuestas se den en json
    configresponse : morgan("dev"), // ayuda a ver las peticiones en log de lo que se envia al servidor
    configcorsdev: cors(cors_dev),
    // configcorsdev: (req, res, next) => {
    //     res.header('Access-Control-Allow-Origin', "*");
    //     res.header('Access-Control-Allow-Methods','GET,PUT,POST,DELETE');
    //     res.header('Access-Control-Allow-Headers', 'Content-Type');
    //     res.header('Access-Control-Allow-Credentials', 'true');
    //     res.setHeader("Access-Control-Allow-Headers", "Access-Control-Allow-Headers, Origin,Accept, X-Requested-With, Content-Type, Access-Control-Request-Method, Access-Control-Request-Headers");
    //     next();
    // },
    configcorsprov :  cors(cors_product),
    midellerror : midellerror
}