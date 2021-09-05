const mongoose = require("mongoose");
const mongoosePaginate = require("mongoose-paginate");

const SuggestionSchema = new mongoose.Schema({
  
  countdown: { type: Number, default: 0 },
  foodId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "Food",
  },
  exerciseId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "Exercise",
  },
  symptoms: { type: String, default: "" },
  timeline: { type: String, default: "" },
  description: { type: String, default: "" },
});

SuggestionSchema.plugin(mongoosePaginate);

module.exports = mongoose.model("Suggestion", SuggestionSchema);
