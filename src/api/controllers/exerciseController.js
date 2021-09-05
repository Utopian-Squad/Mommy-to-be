const { validationResult } = require("express-validator");
const Exercise = require("../models/exerciseModel");

async function getOneExercise(req, res, next) {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({
        status: "error",
        message: errors.array()[0].msg,
      });
    }

    const exercise = await Exercise.findById(req.params.id);
    if (!exercise) {
      return res.status(404).json({
        status: "error",
        message: "exercise with this ID does not exist",
      });
    }
    res.status(200).json({
      status: "success",
      exercise,
    });
  } catch (error) {
    console.log(error);
  }
}

async function getAllExercises(req, res, next) {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({
        status: "error",
        message: errors.array()[0].msg,
      });
    }

    const page = req.query.page * 1 || 1;
    const limit = req.query.limit * 1 || 10;

    const result = await Exercise.paginate(
      {},
      {
        page,
        limit,
        sort: "-createdAt",
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

async function createExercise(req, res, next) {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({
        status: "error",
        message: errors.array()[0].msg,
      });
    }
    if (!req.file) {
      req.file = { filename: `default.png` };
    }

    const exercise = await Exercise.create({
      ...req.body,
      image: req.file.filename,
    });
    res.status(201).json({
      status: "success",
      exercise,
    });
  } catch (error) {
    console.log(error);
  }
}

async function updateExercise(req, res, next) {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({
        status: "error",
        message: errors.array()[0].msg,
      });
    }
    console.log(req.body);

    const exercise = await Exercise.findByIdAndUpdate(req.params.id, req.body, {
      new: true,
    });
    if (!exercise) {
      return res.status(404).json({
        status: "error",
        message: "Exercise with this ID does not exist",
      });
    }
    res.status(200).json({
      status: "success",
      exercise,
    });
  } catch (error) {
    console.log(error);
  }
}

async function deleteExercise(req, res, next) {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({
        status: "error",
        message: errors.array()[0].msg,
      });
    }

    const exercise = await Exercise.findByIdAndDelete(req.params.id);

    if (!exercise) {
      return res.status(404).json({
        status: "error",
        message: "Exercise with this ID does not exist",
      });
    }
    res.status(200).json({
      status: "success",
      exercise: null,
    });
  } catch (error) {
    console.log(error);
  }
}

module.exports = {
  getOneExercise,
  getAllExercises,
  updateExercise,
  deleteExercise,
  createExercise,
};
