const keysconfig = require("./key.json");

let config = {
  bd: {
    mongo: {
      host: "localhost",
      bd: "notes-app",
    },
    mysql: {
      tipeOption: "pool",
      single: {
        host: "localhost",
        port: 3306,
        user: "root",
        password: "",
        database: "canvarit_practica",
      },
      pool: {
        multipleStatements: true,
        connectionLimit: 5,
        "host"    : keysconfig.bdcpanel.HOST,
        "port"    : keysconfig.bdcpanel.PORT,
        "user"    : keysconfig.bdcpanel.USSER,
        "password": keysconfig.bdcpanel.PASSWORD,
        "database": keysconfig.bdcpanel.DATABASE
        // host: "localhost",
        // port: 3306,
        // user: "root",
        // password: "",
        // database: "canvarit_practica",
      },
    },
  },
  apires: {
    portpru: 5001,
    hosturl: "localhost",
    control_access: {
      origin: [
        "http://localhost:8000",
        "http://localhost:3000",
        "http://localhost:3001",
      ],
      methods: ["GET", "HEAD", "PUT", "PATCH", "POST", "DELETE", "OPTIONS"],
      preflightContinue: false,
      optionsSuccessStatus: 204,
    },
  },
  apidatkey: {
    id: 969280255,
    nombre: "bradcar",
    email: "ucv2021@email.com",
  },
};

module.exports = config;
