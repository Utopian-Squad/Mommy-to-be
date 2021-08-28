<<<<<<< HEAD
const express = require('express');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');

// Create express app
const suggestionController = express();

// Database
mongoose.connect('mongodb://localhost/motivation', {
	useNewUrlParser: true,
	useUnifiedTopology: true
});

const db = mongoose.connection;

db.once('open', () => {
	console.log("Connected to MongoDB database...");
});

// Middleware
suggestionController.use(bodyParser.json());

// Routes
suggestionController.get("/", (req, res) => {
  res.send("Pregnancy Suggestions");
});

const SuggestionsRoute = require('../routes/Suggestion');

suggestionController.use("/suggestions", SuggestionsRoute);

// Starting server
suggestionController.listen(3000, console.log("Listening on port 3000"));
=======
const suggestionModel = require("../models/suggestionModel")

function getOneSuggestion(req,res){

}

function getAllSuggestions(req,res){
    res.send("Hello User")
}

function createSuggestion(req,res){


}

function updateSuggestion(req,res){


}

function deleteSuggestion(req,res){


}

module.exports = {
   getOneSuggestion,
   getAllSuggestions,
   createSuggestion,
   updateSuggestion,
   deleteSuggestion 
}
>>>>>>> File Structure
