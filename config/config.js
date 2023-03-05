const keysconfig = require('./key.json')

const config = {
  bd: {
    mongo: {
      host: 'localhost',
      bd: 'notes-app'
    },
    mysql: {
      tipeOption: 'pool',
      single: {
        host: 'localhost',
        port: 3306,
        user: 'root',
        password: '',
        database: 'sgpc'
      },
      pool: {
        multipleStatements: true,
        connectionLimit: 5,
        // "host"    : keysconfig.bdcpanel.HOST,
        // "port"    : keysconfig.bdcpanel.PORT,
        // "user"    : keysconfig.bdcpanel.USSER,
        // "password": keysconfig.bdcpanel.PASSWORD,
        // "database": keysconfig.bdcpanel.DATABASE
        host: 'localhost',
        port: 3306,
        user: 'root',
        password: '',
        database: 'sgpc'
      }
    }
  },
  apires: {
    portpru: 5001,
    hosturl: 'localhost',
    control_access: {
      origin: [
        'http://localhost:8000',
        'http://localhost:3000',
        'http://localhost:3001'
      ],
      methods: ['GET', 'HEAD', 'PUT', 'PATCH', 'POST', 'DELETE', 'OPTIONS'],
      preflightContinue: false,
      optionsSuccessStatus: 204
    }
  },
  apidatkey: {
    id: 969280255,
    nombre: 'bradcar',
    email: 'ucv2021@email.com'
  }
}

module.exports = config
