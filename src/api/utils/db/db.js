const mongoose = require("mongoose");

mongoose.Promise = global.Promise
MONGODB_URI = "mongodb://localhost:27017/api"

mongoose.connect(MONGODB_URI, {useNewUrlParser: true},
   ()=>{ console.log("Database Connected");}
    );
