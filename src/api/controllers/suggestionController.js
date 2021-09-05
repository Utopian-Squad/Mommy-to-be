const { validationResult } = require("express-validator");
const Suggestion = require("../models/Suggestionmodel");

async function getOneSuggestion(req, res, next) {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({
        status: "error",
        message: errors.array()[0].msg,
      });
    }

    const suggestion = await Suggestion.findById(req.params.id);
    if (!suggestion) {
      return res.status(404).json({
        status: "error",
        message: "Suggestion with this ID does not exist",
      });
    }
    res.status(200).json({
      status: "success",
      suggestion,
    });
  } catch (error) {
    console.log(error);
  }
}

async function getAllSuggestions(req, res, next) {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({
        status: "error",
        message: errors.array()[0].msg,
      });
    }

    const page = req.query.page * 1 || 1;
    const limit = req.query.limit * 1 || 12;
    let countdown = req.query.countdown || "10"; 
    let x = parseInt(countdown.split(' ')[0]);
    console.log(countdown,x-4, x+4);
    const result = await Suggestion.paginate(
      {
        // $and: [ 
        //   {countdown : {$lte : x + 4} }, 
        //   { countdown: { $gte : x - 4} }
        // ]
        // countdown : x

        countdown:{
          $gte : x-4,
          $lte: x+4
        }
      },
      {
        page,
        limit,
        sort: "countdown",
        populate:"exerciseId foodId"

      }
    );
    res.status(200).json({
      status: "success",
      result,
    });
  } catch (error) {
    console.log(error);
  }
}

async function createSuggestion(req, res, next) {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({
        status: "error",
        message: errors.array()[0].msg,
      });
    }

    const suggestion = await Suggestion.create(req.body);
    res.status(201).json({
      status: "success",
      suggestion,
    });
  } catch (error) {
    console.log(error);
  }
}

async function updateSuggestion(req, res, next) {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({
        status: "error",
        message: errors.array()[0].msg,
      });
    }

    const suggestion = await Suggestion.findByIdAndUpdate(
      req.params.id,
      req.body,
      {
        new: true,
      }
    );
    if (!suggestion) {
      return res.status(404).json({
        status: "error",
        message: "Suggestion with this ID does not exist",
      });
    }
    res.status(200).json({
      status: "success",
      suggestion,
    });
  } catch (error) {
    console.log(error);
  }
}

async function deleteSuggestion(req, res, next) {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({
        status: "error",
        message: errors.array()[0].msg,
      });
    }

    const suggestion = await Suggestion.findByIdAndDelete(req.params.id);

    if (!suggestion) {
      return res.status(404).json({
        status: "error",
        message: "Suggestion with this ID does not exist",
      });
    }
    res.status(200).json({
      status: "success",
      suggestion: null,
    });
  } catch (error) {
    console.log(error);
  }
}

module.exports = {
  getOneSuggestion,
  getAllSuggestions,
  updateSuggestion,
  deleteSuggestion,
  createSuggestion,
};
