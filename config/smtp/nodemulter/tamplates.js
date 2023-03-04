const fs = require('fs')
const path = require('path')
// templates
const contentbasic = require('./html_send/fomato_coment')

const email_basic = (nombre="default",messeg = "Contenido de messege generico") => {
    let content = contentbasic;
    content = content.replace("&nombre&",nombre);
    content = content.replace("&messeg&",messeg)
    return content;
}

module.exports = {
    email_basic: email_basic
}