// creacion de la ruta
const express = require('express');
const rooutes = express.Router();
const multer = require("multer");
const path = require("path");
const fs = require("fs");
const { v4 } = require("uuid");

const googledrive = require('./googledriver3');


const storageftp = multer.diskStorage({
    destination: path.join(__dirname, "../ftp"),
    filename: (req, file, cb) => {
      cb(null, v4() + path.extname(file.originalname).toLowerCase());
    },
  });
  
  const Filercode = (req, file, cb) => {
    const filetypes = /jpeg|jpg|png|gif/;
    const mytype = filetypes.test(file.mimetype);
    const extname = filetypes.test(path.extname(file.originalname));
    if (mytype && extname) {
      return cb(null, true);
    }
    cb("El archivo debe ser una imagen valida");
  }
  
  const insertImage = multer({
    storage: storageftp,
    //dest: "ftp",
    limits: { fieldSize: 10000000 },
    //fileFilter: Filercode,
  }).single("photo");

//readindex
rooutes.get("/render", (req, res) => {
    //res.send(req.params.img)
    res.render("index.ejs");
});

//insertar
rooutes.post('/uploud', async (req, res) => {
    insertImage(req, res, async (err) => {
        if (err) return res.send(err);
        try {
          const files = req.file;
          const resultFile = await googledrive.insertar(files);
          // console.log(resultFile);
          // return res.status(200).json({
          //     messege: "imagen insertada correctamente"
          //     // data:[{
          //     //   url : resultUrl.webContentLink,
          //     //   id : resultFile.id
          //     // }]
          // });
          const resultUrl = await googledrive.generectUrlPublic(resultFile.id);
          return res.status(200).json({
              messege: "El archivo fue subido correctamente.",
              data:[{
                url : resultUrl.webContentLink,
                id : resultFile.id
              }]
          });
        } catch (error) {
          console.log(error);
          return res.json({
            status: 400,
            messege: "Error al insertar el archivo.",
            data:[]
        });
        }
      });
});

// read
// rooutes.get('/read/:id', async (req, res) => {
//     const result = await googledrive.generectUrlPublic(req.params.id);
//     return res.send(result);
// });

//delect
rooutes.get('/delect/:id', async (req, res) => {
    await googledrive.delect(req.params.id);
    return res.send("Eliminado correctamente");
})

module.exports = rooutes