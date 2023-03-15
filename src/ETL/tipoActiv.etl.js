const fs = require('fs')

// ######################### DbclientAnali ###################################
module.exports = class DbtipoActiv {
  async Load () {
  }

  async Extrac () {
    const LoadFilte = fs.readFileSync(require.resolve('./data/tipoActivo.csv'), { encoding: 'utf8' })
    const LoadData = LoadFilte.toString().split('\n')
    return LoadData
  }

  async formatMYSQL (consulte = 'INSERT INTO [nameTable] VALUES', limitInsert = 0, mintCapDatos = 2) {
    const LoadDataCVS = await this.Trasform(mintCapDatos, limitInsert)
    const dataConsult = LoadDataCVS.map((item, index) => {
      const dataColums = item
      const dataTrasnforColumn = dataColums.map((item) => {
        // eslint-disable-next-line no-useless-escape, comma-spacing
        return `'${item}'`
      })
      const dataInserConsult = `( ${dataTrasnforColumn.join(',')} )`
      const transforDataInsert = dataInserConsult + ((parseInt(index) === parseInt(LoadDataCVS.length - 1)) ? ';' : ',').toString()
      return transforDataInsert
    // eslint-disable-next-line eqeqeq
    }).join(' ')
    return consulte + ' ' + dataConsult
  }

  // INSERT INTO `tipoactivo`(`id_tipoActivo`, `nombreTipoActivo`, `abrebiat`, `dependAbreb`, `isDependeTipoPad`, `id_dependeTipoPad`, `estade`) VALUES ('[value-1]','[value-2]','[value-3]','[value-4]','[value-5]','[value-6]','[value-7]')

  async Trasform (mintCapDatos = 2, limitInsert = 0) {
    const LoadDataCVS = await this.Extrac()
    LoadDataCVS.shift()
    const dataConsult = LoadDataCVS.map((item, index) => {
      const dataColums = item.split(',')
      const dataTrasnforColumn = dataColums.map((item) => {
        // eslint-disable-next-line no-useless-escape, comma-spacing
        const correcItemDat = item.replace('\r' , '')
        return `${(correcItemDat === '') ? '0' : correcItemDat}`
      })
      if (dataTrasnforColumn.length < mintCapDatos) return []
      const FormatoInserDatos = [dataTrasnforColumn[0], dataTrasnforColumn[3], dataTrasnforColumn[2], dataTrasnforColumn[1], (parseInt(dataTrasnforColumn[4]) === 0) ? '0' : '1', dataTrasnforColumn[4], '1']
      return FormatoInserDatos
    // eslint-disable-next-line eqeqeq
    }).filter(item => item.length > mintCapDatos).filter((item, index) => { return (limitInsert == 0) ? true : index < limitInsert })
    return dataConsult
  }
// eslint-disable-next-line eol-last
}