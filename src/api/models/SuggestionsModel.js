const mongoose = require('mongoose');

const SuggestionSchema = new mongoose.Schema({
  countdown :String,
  Food_id: String,
  excercise :String ,
  Symptoms: String,
  timeline: String,
  description: String,
});

module.exports = mongoose.model('Suggestion', SuggestionSchema);