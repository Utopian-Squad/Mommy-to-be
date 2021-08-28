const { text } = require('express')
const mongoose = require('mongoose')
//var autoIncrement = require("mongodb-autoincrement");

const exerciseSchema = new mongoose.Schema({

    name: {
        type: String,
        required: true,
    },
    type: {
        type:String,
        required:true,
    },
    duration :{
        type:Number,
        required: false,
    },
    
    display:{
        type:Object,
        required:true,
    },
    decription:{
        type:String, 
        require:false,
    }



})

//exerciseSchema.plugin(autoIncrement.mongoosePlugin);

module.exports=mongoose.model('Exercise',exerciseSchema)