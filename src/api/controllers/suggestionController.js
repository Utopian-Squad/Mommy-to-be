const Suggestion = require("../models/suggestionModel")


async function getAllSuggestions(req,res){
	const suggestions = await Suggestion.find();

	res.json(suggestions);

}

async function getOneSuggestion(req,res){
	const q = await Suggestion.findById({ _id: req.params.id });

	res.json(q);

}

async function createSuggestion(req,res){
	const newSuggestion = new Suggestion(req.body);
	
	const savedSuggestion = await newSuggestion.save();

	res.json(savedSuggestion);

}

async function updateSuggestion(req,res){
	const q = await Suggestion.updateOne({_id: req.params.id}, {$set: req.body});

	res.json(q);

}

async function deleteSuggestion(req,res){

	const result = await Suggestion.findByIdAndDelete({ _id: req.params.id });

	res.json(result);
}

async function randomSuggestion(req,res){
	const count = await Suggestion.countDocuments();
	const random = Math.floor(Math.random() * count);
	const q = await Suggestion.findOne().skip(random);

	res.json(q);

}

module.exports = {

	getAllSuggestions,
	getOneSuggestion,
	createSuggestion,
	updateSuggestion,
	randomSuggestion,
	deleteSuggestion
}