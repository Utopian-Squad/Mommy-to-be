const mongoose = require("mongoose");

mongoose.Promise = global.Promise
MONGODB_URI = "mongodb://localhost:27017/api"

mongoose.connect(MONGODB_URI, {useNewUrlParser: true},
   ()=>{ console.log("Database Connected");}
    );
<<<<<<< HEAD
=======

>>>>>>> 0ce21dce198534491cc9a27e52f052ca38978832
