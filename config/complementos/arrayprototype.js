
function groupby (keygroup = '', array = []){
  const arraybas = {}
  array.forEach((item)=>{
    let key = item[keygroup];
      if (arraybas.hasOwnProperty(key)){
        arraybas[key].push(item);
      }else{
        arraybas[key] = [];
        arraybas[key].push(item);
      }
    })

    return arraybas;
}

module.exports = {
    groupby
};