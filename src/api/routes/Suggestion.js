const express = require('express');
const router = express.Router();
const Suggestion = require("../models/SuggestionsModel");

// Get all routes
router.get('/', async (req, res) => {
	const suggestions = await Suggestion.find();

	res.json(suggestions);
});

// Create new Suggestions
router.post('/new', async (req, res) => {
	const newSuggestion = new Suggestion(req.body);
	
	const savedSuggestion = await newSuggestion.save();

	res.json(savedSuggestion);
});

// Get specific Suggestion
router.get('/get/:id', async (req, res) => {
	const q = await Suggestion.findById({ _id: req.params.id });

	res.json(q);
});

// Delete a Suggestion
router.delete('/delete/:id', async (req, res) => {
	const result = await Suggestion.findByIdAndDelete({ _id: req.params.id });

	res.json(result);
});

// Update a Suggestion
router.patch('/update/:id', async (req, res) => {
	const q = await Suggestion.updateOne({_id: req.params.id}, {$set: req.body});

	res.json(q);
});

// Get random Suggestion
router.get('/random', async (req, res) => {
	const count = await Suggestion.countDocuments();
	const random = Math.floor(Math.random() * count);
	const q = await Suggestion.findOne().skip(random);

	res.json(q);
});

module.exports = router;