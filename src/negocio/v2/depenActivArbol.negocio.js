const BddepenActivArbol = require('../../model/v2/depenActivArbol.bd')
const objdepenActivArbol = new BddepenActivArbol()
const BdprocesActit = require('../../model/v2/activproces.bd')
const objprocesActit = new BdprocesActit()

module.exports = class ngdepenActivArbol {
  async inser_depenActivArbol (req, res) {
    const result = await objdepenActivArbol.inser_DbdepenActivArbol(req, res)
    res.send({
      status: 200,
      typo: 'succes',
      messege: result
    })
  }

  async get_depenActivArbol (req, res) {
    const result = await objdepenActivArbol.list_DbdepenActivArbol(req, res)
    return result
  }

  async list_depenActivArbol (req, res) {
    const result = await this.get_depenActivArbol(req, res)
    res.json(result)
  }

  // {
  //   "id_dependActivArbol": 1,
  //   "id_tipoActivo": 1,
  //   "abreb": "essential",
  //   "id_ActiviDepent": 0,
  //   "depenabreb": null
  // },

  async get_dependenofabreb (req, res) {
    const abret = req.params.abrebiat
    const proce = req.params.id_proceso
    // captura la abrebiatura master
    const result = this.strackAbrebArray(abret)
    const itemElement = result[0]
    // capturar las abrebiaturas dependientes a la abrebiatura master
    const rsultDepent = await this.get_depenActivArbol(req, res)
    const tiposDepent = rsultDepent.filter((item) => {
      // eslint-disable-next-line eqeqeq
      return (item.abreb == itemElement)
    })
    const ListAbreb = tiposDepent.map((item) => {
      return item.depenabreb
    })
    ListAbreb.push(itemElement)
    // capturar los activos dependientes
    const listActivProces = await objprocesActit.list_activproces(req, res, proce)
    const filterData = listActivProces.filter((item) => {
      const Listabrebr = this.strackAbrebArray(item.dependAbreb)
      const abrebrMaster = Listabrebr[0]
      return ListAbreb.indexOf(abrebrMaster) !== -1
    })
    res.send(filterData)
  }

  strackAbrebArray (abreb = 'essential.info.per.regular.5') {
    const ListItemAbrebitem = abreb.split('.')
    const ListCombItemAbrebitem = []
    ListItemAbrebitem.forEach((item) => {
      if (ListCombItemAbrebitem.length === 0) {
        ListCombItemAbrebitem.push(item)
      } else {
        const abrebItem = ListCombItemAbrebitem[ListCombItemAbrebitem.length - 1] + '.' + item
        ListCombItemAbrebitem.push(abrebItem)
      }
    })
    return ListCombItemAbrebitem
  }

  // async eliminar_areainterproce (req, res) {
  //   const result = await objareainterproce.eliminar_areainterproce(req, res)
  //   res.json(result)
  // }
}
