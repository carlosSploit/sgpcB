const jwt = require('jsonwebtoken')
// archivo de configuracion
const config = require('../config.js')

// verificacion del token
module.exports = function verifyToken (req, res, next) {
  if (!req.headers.authorization) {
    return res.status(403).send({ message: 'No tienes autorizacion' })
  }
  // si existe sigue la operacion
  const tokenext = req.headers['authorization']
  console.log(req.headers['authorization'])
  if (typeof tokenext !== 'undefined') {
    const listdatetoken = tokenext.split(' ')
    const token = listdatetoken[listdatetoken.length - 1]
    const payload = jwt.decode(token, config.apidatkey)
    if (payload == null) return res.status(403).send({ message: 'No tienes autorizacion' })
    // coomprobamos la existencia de las key y sus valores dados, entre el json esperado y el json desifrado
    for (const key in config.apidatkey) {
      try {
        if (payload.user[key] != config.apidatkey[key]) {
          return res.status(403).send({ message: 'El toquen es invalido' })
        }
      } catch (Exeption) {
        return res.status(403).send({ message: 'El formato de la key no conside coon el formato esperado' })
      }
    }
    req.token = token
    next()
  } else {
    return res.status(403).send({ message: 'No presenta el token' })
  }
// eslint-disable-next-line eol-last
}