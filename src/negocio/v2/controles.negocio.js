const Bdcontroles = require('../../model/v2/controles.bd')
const objcontroles = new Bdcontroles()
const Bdclasscontroles = require('../../model/v2/classcontroles.bd')
const objclasscontroles = new Bdclasscontroles()

// const ValideCorreoandPassUpdate = async (req, res) => {
//   // se verifica que que no hayan cambios
//   const listinfoadmin = await objclienAnalit.read_admin(req, res)
//   const datainfoadmin = listinfoadmin[0]
//   console.log(datainfoadmin)
//   if (!(((datainfoadmin.correo + '') === (req.body.correo + '')) && ((datainfoadmin.pass + '') === (req.body.pass + '')))) {
//     const valideCorAndPass = await ValideCorreoandPass(req, res)
//     // si ya existe un usuario con el mismo correo y contraseña
//     if (valideCorAndPass.status === 404) return valideCorAndPass
//   }
//   // si no existe el usuario con el correo y contraseña
//   return {
//     status: 200
//   }
// }

module.exports = class ngcontroles {
  async inser_controles (req, res) {
    const result = await objcontroles.inser_controles(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }

  async list_controles (req, res) {
    const result = await objcontroles.list_controles(req, res)
    const resultList = await objclasscontroles.list_classcontrol(req, res, 0)
    const listDataFinal = resultList.map((item) => {
      const listFilter = result.filter((itemAux) => {
        return parseInt(itemAux.id_classControl) === parseInt(item.id_classControl)
      })
      const itemData = {
        id_control: item.id_classControl * 2000,
        id_classControl: 0,
        codigo: item.abrebClassControl,
        codeDepende: item.abrebClassControl,
        DescripccionControl: item.nombreClassControl,
        tipoControl: 'CLA',
        id_depencontrol: 0,
        estade: 1
      }
      const listFilterFinal = listFilter.map((itemAux) => {
        const ObjAux = { ...itemAux }
        ObjAux.id_depencontrol = (parseInt(ObjAux.id_depencontrol) === 0) ? item.id_classControl * 2000 : ObjAux.id_depencontrol
        return ObjAux
      })
      return [itemData, ...listFilterFinal]
    })
    const finalArray = listDataFinal.reduce((prev, curre) => {
      const listAux = [...prev]
      const listAuxF = listAux.concat(curre)
      return listAuxF
    }, [])
    res.json(finalArray)
  }
}
