const fs = require('fs')

// ######################### DbclientAnali ###################################
module.exports = class DbDependeciActivArbol {
  async Load () {
  }

  async Extrac () {
    const LoadFilte = fs.readFileSync(require.resolve('./data/criteriosValori.csv'), { encoding: 'utf8' })
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

  // INSERT INTO `criteriosvalor`(`id_criteriosValor`, `id_tipoCriterValor`, `abreb`, `valori`, `descripcCriterio`, `estade`)

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
      const FormatoInserDatos = [dataTrasnforColumn[0], dataTrasnforColumn[1], dataTrasnforColumn[2], dataTrasnforColumn[3], dataTrasnforColumn[4], '1']
      return FormatoInserDatos
    // eslint-disable-next-line eqeqeq
    }).filter(item => item.length > mintCapDatos).filter((item, index) => { return (limitInsert == 0) ? true : index < limitInsert })
    return dataConsult
  }
// eslint-disable-next-line eol-last
}