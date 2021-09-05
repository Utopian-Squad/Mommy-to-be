const mongoose = require("mongoose");
const mongoosePaginate = require("mongoose-paginate");

const foodSchema = new mongoose.Schema({
  name: {
    type: String,
  },
  type: {
    type: String,
  },
  image: {
    type: String,
    default: "food_default.png",
  },
  display: {
    type: Object,
  },
  description: {
    type: String,
  },
});

foodSchema.plugin(mongoosePaginate);

module.exports = mongoose.model("Food", foodSchema);
