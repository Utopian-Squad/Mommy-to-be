const mongoose = require("mongoose");

const messageSchema = new mongoose.Schema({
    chatroom: {
        type:mongoose.Schema.Types.ObjectId,
        required: 'Chatroom is required',
        ref:"Chatroom",
    },
    User:{
        type:mongoose.Schema.Types.ObjectId,
        required:"Chatroom is required",
        ref:"User",
    },
    message: {
        type:String,
        required: 'message is required'
    },
   
});

module.exports = mongoose.model("Message",messageSchema);