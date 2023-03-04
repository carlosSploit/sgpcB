// const enviarmess = require('../../config/smtp/nodemulter/nodemulter')
const Validator = require('../../config/complementos/validator')
const objvalit = new Validator()
const Bdalumno = require('../model/bd_alumno')
const objalumno = new Bdalumno()
const BdtutAlum = require('../model/bd_tutAlum')
const objtutAlum = new BdtutAlum()

const Valideinsert = (req) => {
  const valida =
    objvalit.validator_vacio(req.body.name) ||
    objvalit.validator_celular(req.body.telf) ||
    objvalit.validator_mail(req.body.correo) ||
    objvalit.validator_vacio(req.body.pass) ||
    objvalit.validator_edad(req.body.edad) ||
    objvalit.validator_url(req.body.photo)

  const dataarray = [
    {
      datacom: 'name',
      valide: objvalit.validator_vacio(req.body.name)
    },
    {
      datacom: 'telf',
      valide: objvalit.validator_celular(req.body.telf)
    },
    {
      datacom: 'correo',
      valide: objvalit.validator_mail(req.body.correo)
    },
    {
      datacom: 'pass',
      valide: objvalit.validator_vacio(req.body.pass)
    },
    {
      datacom: 'edad',
      valide: objvalit.validator_edad(req.body.edad)
    },
    {
      datacom: 'photo',
      valide: objvalit.validator_url(req.body.photo)
    }
  ]

  const auxvalidetdata = dataarray.filter((item) => {
    return item.valide
  })
  console.log(auxvalidetdata)
  return { valida, auxvalidetdata }
}

const ValideCorreoandPass = async (req, res) => {
  // se verifica si el usuario o la contraseña ya estan registrados o no
  const valitusser = await objvalit.validator_user(
    req,
    res,
    req.body.correo,
    req.body.pass
  )
  if (valitusser) {
    // si ya existe un usuario con el mismo correo y contraseña
    return {
      status: 404,
      typo: 'error',
      messege: 'El correo y la contraseña ya pertenecen a un usuario'
    }
  }
  return {
    status: 200
  }
}

const ValideCorreoandPassUpdate = async (req, res) => {
  // se verifica que que no hayan cambios
  const listinfoalumno = await objalumno.read_alumno(req, res)
  const datainfoalumno = listinfoalumno[0]
  console.log(datainfoalumno)
  if (!(((datainfoalumno.correo + '') === (req.body.correo + '')) && ((datainfoalumno.pass + '') === (req.body.pass + '')))) {
    const valideCorAndPass = await ValideCorreoandPass(req, res)
    // si ya existe un usuario con el mismo correo y contraseña
    if (valideCorAndPass.status === 404) return valideCorAndPass
  }
  // si no existe el usuario con el correo y contraseña
  return {
    status: 200
  }
}

const ValideIdTutorExisten = async (req, res) => {
  // valida si el profesor existe
  const dataListTitAlum = await objtutAlum.list_tutalum(req, res)
  const listobjdatatuto = dataListTitAlum.filter((item) => {
    return (parseInt(item.id_tutor_alumno) === parseInt(req.body.id_tutor))
  })
  // si no encuentra ningun tutor con la id ingresada
  if (listobjdatatuto.length === 0) {
    return {
      status: 404,
      typo: 'error',
      messege: 'El codigo del tutor no existe en los datos actuales',
      data: [
        {
          datacom: 'id_tutor',
          valide: false
        }
      ]
    }
  }
  return {
    status: 200,
    typo: 'succes',
    messege: '',
    data: listobjdatatuto
  }
}

module.exports = class ngprofesor {
  async inser_alumno (req, res) {
    // validar datos insertados
    const validado = Valideinsert(req)

    if (validado.valida) {
      res.send({
        status: 404,
        typo: 'error',
        messege: 'casillas mal ingresadas',
        data: validado.auxvalidetdata
      })
      return
    }

    // validar si el usuario existe si se ingresa nuevos usuarios y contraseñas
    const valideCorPass = await ValideCorreoandPass(req, res)
    if (valideCorPass.status === 404) return res.send(valideCorPass)

    // validar datos de inserrcion, si es mayor de 18 se usa el id del tutor del alumno para luego ser filtrado en la lista de datos de tutor
    const data = { ...req.body }
    // const dataListTitAlum = await objtutAlum.list_tutalum(req, res)
    // validar si el alumno es mayor o menor
    if (parseInt(data.edad) >= 18) {
      req.body.id_tutor = 0
      req.body.name_tutor = 'desconocido'
      // le envian un correo de bienvenida al usuario
      // let messege = `Gracias por confiar en nosotros ${req.body.name}, ojala que te guste nuestro servicio de talleres, inscribete a nuestros talleres variados a tu gusto.`;
      // let title = `! Bienvenido a Canvaritech ¡`;
      // enviarmess(req.body.correo,title,messege);

      const result = await objalumno.inser_alumno(req, res)
      res.send({
        status: 200,
        typo: 'succes',
        messege: result
      })
      return
    }

    console.log('El alumno aun es menor')
    // valida si el dato del tutor del alumno
    const valideIdtuto = await ValideIdTutorExisten(req, res)
    if (valideIdtuto.status === 404) return res.send(valideIdtuto)
    const listobjdatatuto = valideIdtuto.data
    // se inicializa los datos
    const objdatatuto = { ...listobjdatatuto[0] }
    req.body.name_tutor = objdatatuto.nombre
    req.body.telf = objdatatuto.telf

    // le envian un correo de bienvenida al usuario
    // let messege = `Gracias por confiar en nosotros ${req.body.name}, ojala que te guste nuestro servicio de talleres, inscribete a nuestros talleres variados a tu gusto.`;
    // let title = `! Bienvenido a Canvaritech ¡`;
    // enviarmess(req.body.correo,title,messege);

    const result = await objalumno.inser_alumno(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }

  async actuali_alumno (req, res) {
    // validar si el usuario existe si se ingresa nuevos usuarios y contraseñas
    const valideCorPass = await ValideCorreoandPassUpdate(req, res)
    if (valideCorPass.status === 404) return res.send(valideCorPass)
    // validar datos insertados
    const validado = Valideinsert(req)

    if (validado.valida) {
      res.send({
        status: 404,
        typo: 'error',
        messege: 'casillas mal ingresadas',
        data: validado.auxvalidetdata
      })
      return
    }

    // validar datos de inserrcion, si es mayor de 18 se usa el id del tutor del alumno para luego ser filtrado en la lista de datos de tutor
    const data = { ...req.body }
    // validar si el alumno es mayor o menor
    if (parseInt(data.edad) >= 18) {
      req.body.id_tutor = 0
      req.body.name_tutor = 'desconocido'

      const result = await objalumno.actuali_alumno(req, res)
      res.send({
        status: 200,
        typo: 'succes',
        messege: result
      })
      return
    }

    console.log('El alumno aun es menor')
    // valida si el dato del tutor del alumno
    const valideIdtuto = await ValideIdTutorExisten(req, res)
    if (valideIdtuto.status === 404) return res.send(valideIdtuto)
    const listobjdatatuto = valideIdtuto.data
    // se inicializa los datos
    const objdatatuto = { ...listobjdatatuto[0] }
    req.body.name_tutor = objdatatuto.nombre
    req.body.telf = objdatatuto.telf

    // le envian un correo de bienvenida al usuario
    // let messege = `Gracias por confiar en nosotros ${req.body.name}, ojala que te guste nuestro servicio de talleres, inscribete a nuestros talleres variados a tu gusto.`;
    // let title = `! Bienvenido a Canvaritech ¡`;
    // enviarmess(req.body.correo,title,messege);

    const result = await objalumno.actuali_alumno(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }

  async list_alumno (req, res) {
    const result = await objalumno.list_alumno(req, res)
    res.json(result)
  }

  async delect_alumno (req, res) {
    const result = await objalumno.delect_alumno(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result,
      data: []
    })
  }

  async read_alumno (req, res) {
    const result = await objalumno.read_alumno(req, res)
    // valida si el coligo del alumno existe
    if (result.length === 0) {
      res.send({
        status: 404,
        typo: 'error',
        messege: 'El codigo del alumno no existe',
        data: {
          datacom: 'id_alumno',
          valide: false
        }
      })
      return
    }
    // si es mayor de edad
    const dataObj = { ...result[0] }
    if (dataObj.edad >= 18) {
      res.json(dataObj)
      return
    }
    // si es menor de edad
    // valida si el dato del tutor del alumno
    req.body.id_tutor = result[0].id_tutor_alumno // se le añade dentro del body el id del tutor para hacer la validacion
    const valideIdtuto = await ValideIdTutorExisten(req, res)
    if (valideIdtuto.status === 404) return res.send(valideIdtuto)
    const listobjdatatuto = valideIdtuto.data
    // inicializa los datos del tutor
    const dataObjtuto = listobjdatatuto[0]
    dataObj.name_tutor = dataObjtuto.nombre
    dataObj.telf_tutor = dataObjtuto.telf
    dataObj.corr_tutor = dataObjtuto.correo
    // console.log(filterdattuto);
    // dataObj["telf_tutor"]
    res.json(dataObj)
  }
}
