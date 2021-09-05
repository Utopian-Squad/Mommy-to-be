const { text } = require("express");
const mongoose = require("mongoose");
const mongoosePaginate = require("mongoose-paginate");
//var autoIncrement = require("mongodb-autoincrement");

const exerciseSchema = new mongoose.Schema({
  name: {
    type: String,
  },
  type: {
    type: String,
  },
  duration: {
    type: String,
  },
  image: {
    type: String,
    default: "exerciseDefault.png",
  },

  description: {
    type: String,
  },
});

exerciseSchema.plugin(mongoosePaginate);

module.exports = mongoose.model("Exercise", exerciseSchema);
