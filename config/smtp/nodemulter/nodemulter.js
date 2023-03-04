/* 
    nombre: Cavarithprueba
    apellido: superada
    email: cavarithprueba2004@gmail.com
    pass: @Aa96920255

    // https://www.youtube.com/watch?v=uXtZVPwLuDs
*/
const config = require("../../key.json");
const fs = require("fs");
const path = require("path");
const nodemailer = require("nodemailer");
const { google } = require("googleapis");
const template = require("./tamplates");

const tokengoogle = async () => {
  const oAunt = new google.auth.OAuth2(
    config.gmailcredencial.CLIENT_ID,
    config.gmailcredencial.CLIENT_SECRET,
    config.gmailcredencial.REDIRECT_URI
  );
  oAunt.setCredentials({ refresh_token: config.gmailcredencial.REFRESH_TOKEN });
  const token = await oAunt.getAccessToken();
  return token;
};

const authconfig = async (conf = "clasic") => {
  if ("clasic" == conf)
    return {
      user: config.gmailcredencial.USSER,
      pass: config.gmailcredencial.PASS,
    };
  return {
    type: "OAUTH2",
    user: config.gmailcredencial.USSER,
    clientId: config.gmailcredencial.CLIENT_ID,
    clientSecret: config.gmailcredencial.CLIENT_SECRET,
    refreshToken: config.gmailcredencial.REFRESH_TOKEN,
    accessToken: await tokengoogle(),
  };
};

const enviarmessege = async (
  to = "cavarithprueba2004@gmail.com",
  title = "Titulo por predeterminado",
  messege = "Mensaje de contenido default",
  format = ""
) => {
  /*
        configuracion estandar:
        
        host: "correoprueba.email",
        post: 587,
        secure: false,
        auth:{
            user : "akdjasdjk",
            pass : "sdfhsdkjfhdskf"
        }, 
    */

  // conexion de google correo
  try {
    const transport = nodemailer.createTransport({
      service: "gmail",
      auth: await authconfig("outh"),
    });
  } catch (error) {
    // si esque hay un error en capturar un nuevo token emprimira el error
    // este metodo evitara que la api se caiga al realizar este proceso
    console.log(error);
  }

  // conexion de cpanel canvaritech
  // const transport = nodemailer.createTransport({
  //     host: config.cpanelsmtp.HOST,
  //     port: config.cpanelsmtp.PORT,
  //     logger: true,
  //     debug: true,
  //     secure: true,
  //     auth:{
  //         user: config.cpanelsmtp.USSER,
  //         pass: config.cpanelsmtp.PASS
  //     }
  // });

  // conexion de ethereal.email
  // const transport = nodemailer.createTransport({
  //     host: config.etereosmtp.HOST,
  //     post: config.etereosmtp.PORT,
  //     // logger: true,
  //     // debug: true,
  //     secure: false,
  //     auth:{
  //         user: config.etereosmtp.USSER,
  //         pass: config.etereosmtp.PASS
  //     },
  //     // tls:{
  //     //     rejectUnauthorized: false
  //     // }
  // });

  let htmlstream = template.email_basic(title, messege);

  var mailOptions = {
    from: `Canvarith`,
    to: `${to}`,
    subject: "Enviando desde nodemailer",
    html: htmlstream,
  };

  try {
    transport.sendMail(mailOptions, (error, info) => {
      if (error) {
        console.log(error);
        return;
      } else {
        console.log("Email enviado.");
        console.log(info);
      }
    });
  } catch (error) {
    console.log(error);
  }
};

module.exports = enviarmessege;
