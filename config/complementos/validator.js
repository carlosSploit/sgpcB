const Bdusuario = require('../../src/model/bd_usuario')
const objusuario = new Bdusuario()
// valida true si esque hay un error y es false si todo esta correcto

module.exports = class Validator {
  // si da un error retornara un false
  async validator_user (req, res, correo, pass) {
    if (this.validator_mail(correo)) return false
    if (this.validator_vacio(pass)) return false
    const arrayreul = await objusuario.compro_logusser(req, res, correo, pass)
    const cantiresul = arrayreul.length
    if (parseInt(cantiresul) !== 0) {
      return true
    }
    return false
  }

  validator_vacio (text = '') {
    // console.log(text)
    if (text == null || text === undefined || text.length === 0) return true
    return text === ''
  }

  validator_integer (textd = '') {
    const cadena = (textd + '')
    if (this.validator_vacio((cadena))) return true
    const expres = /^\d+$/
    return !expres.test(cadena)
  }

  validator_decimal (textd = '') {
    const cadena = (textd + '')
    if (this.validator_vacio((cadena))) return true
    if (cadena === '0') return false
    const expres = /^[0-9]+([,|.][0-9]+)$/
    return !expres.test(cadena)
  }

  validator_celular (celular = '') {
    const cadena = (celular + '')
    if (this.validator_vacio((cadena))) return true
    const expres2 = /^((^(\()?(\+\s?\d{1,})(\))?)(\s)?)?((\d{9}$)|(\d{3}(\s|-)?\d{3}(\s|-)?\d{3}$))/
    return !expres2.test(cadena)
  }

  validator_edad (edad = '') {
    const cadena = (edad + '')
    if (this.validator_vacio((cadena))) return true
    if (this.validator_integer((cadena))) return true
    const expres2 = /^\d{1,3}$/
    return !expres2.test(cadena)
  }

  validator_url (url = '') {
    const cadena = (url + '')
    if (this.validator_vacio((cadena))) return true
    const expres = /^(http|https)(:\/\/)(((\w{0,}\.)?(\w{0,}\.\w{0,3}))(:\d{1,65555})?)(\S{0,})?$/
    return !expres.test(cadena)
  }

  validator_mail (mail = '') {
    const cadena = (mail + '')
    if (this.validator_vacio((cadena))) return true
    if (cadena === '0') return false
    const expres = /^[\w]+([@])([\w]{0,})([.]\w{0,3})$/
    return !expres.test(cadena)
  }

  validator_date (date = '') {
    const cadena = (date + '')
    if (this.validator_vacio(cadena)) return true
    const expres = /^(\d{4})(-)(\d{2})(-)(\d{2})/
    if (!expres.test(cadena)) return true
    const isValidDate = Date.parse(`${cadena}T00:00:00`)
    return isNaN(isValidDate)
  }

  convert_date_minisecons (date = '') {
    if (this.validator_date(date)) return 0
    const dateobj = new Date(date)
    return dateobj.getTime()
  }

  validator_date_men_date (datein = '', datefin = '') {
    if (this.validator_date(datein)) return true
    if (this.validator_date(datefin)) return true
    // valida si es menos o mayor
    const miniseconsinit = this.convert_date_minisecons(datein)
    const miniseconsfin = this.convert_date_minisecons(datefin)
    return !(miniseconsinit < miniseconsfin)
  }

  validator_date_range_day (datein = '', datefin = '', daydif = 0) {
    if (this.validator_date_men_date(datein, datefin)) return true
    const miniseconsInit = this.convert_date_minisecons(datein)
    const miniseconsFin = this.convert_date_minisecons(datefin)
    const diferentminisecons = Math.abs(miniseconsInit - miniseconsFin)
    const miniseconsToDay = diferentminisecons / 86400000
    if (daydif <= miniseconsToDay) {
      return false
    } else {
      return true
    }
  }
}
