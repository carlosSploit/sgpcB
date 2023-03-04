/* eslint-disable no-undef */
const app = require('../../src/server.config')
const request = require('supertest')

describe('Validacion de rutas de Usuario:', () => {
  describe('Valida si el usuario y contraseña existen patch : /api2/usuar/complog', () => {
    test('Valida con un Admincanvaritch@admin.com - 17072022devcanv que el status sea 200', async () => {
      const resutl = await request(app).post('/api2/usuar/complog').set({ 'Content-Type': 'application/json' }).send({
        usser: 'Admincanvaritch@admin.com',
        pass: '17072022devcanv'
      })
      expect(resutl.statusCode).toBe(200)
    })
    test('Valida con un Admincanvaritch@admin.com - 17072022devcanv retorna el tipo de usuario con exito', async () => {
      const resutl = await request(app).post('/api2/usuar/complog').set({ 'Content-Type': 'application/json' }).send({
        usser: 'Admincanvaritch@admin.com',
        pass: '17072022devcanv'
      })
      expect(true).toBe((Object.keys(resutl.body).indexOf('tipo_user') !== -1))
    })
    test('Valida con un Admincanvaritch@admin.com - jdsfkjdsfklsd retorna que el usurios es desconocido', async () => {
      const resutl = await request(app).post('/api2/usuar/complog').set({ 'Content-Type': 'application/json' }).send({
        usser: 'Admincanvaritch@admin.com',
        pass: 'asjdksajdsa'
      })
      expect(false).toBe((Object.keys(resutl.body).indexOf('tipo_user') !== -1))
    })
  })
})
