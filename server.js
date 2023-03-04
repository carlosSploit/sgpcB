const app = require('./src/server.config')
// resever runnig----------------------------------------------------------------
app.listen(app.get('port'), () => {
  console.log('servidor se encuentra corriendo por el puerto', app.get('port'))
})
