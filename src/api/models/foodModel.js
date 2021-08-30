const mongoose = require('mongoose')

const foodSchema = new mongoose.Schema({

    

    name: {
        type: String,
        required: true,
    },
    type: {
        type:String,
        required:true,
    },
   
    
    display:{
        type:Object,
        required:false,
    },
    decription:{
        type:String, 
        require:false,
    }



})



module.exports=mongoose.model('Food',foodSchema)