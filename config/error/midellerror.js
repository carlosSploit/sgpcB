const errormidelware = (error,req,res,next ) => {
    console.log({
        status:'error',
        name: error.name,
        message : error.message,
        path: error.path
    })
    res.status(400).json({
        status:'error',
        name: error.name,
        message : error.message,
        path: error.path
    });
}

module.exports = errormidelware;