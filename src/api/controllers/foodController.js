const { validationResult } = require("express-validator");
const Food = require("../models/foodModel");

async function getOneFood(req, res, next) {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({
        status: "error",
        message: errors.array()[0].msg,
      });
    }

    const food = await Food.findById(req.params.id);
    if (!food) {
      return res.status(404).json({
        status: "error",
        message: "food with this ID does not exist",
      });
    }
    res.status(200).json({
      status: "success",
      food,
    });
  } catch (error) {
    console.log(error);
  }
}

async function getAllFoods(req, res, next) {
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

    const result = await Food.paginate(
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

async function createFood(req, res, next) {
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

    const food = await Food.create({
      ...req.body,
      image: req.file.filename,
    });
    res.status(201).json({
      status: "success",
      food,
    });
  } catch (error) {
    console.log(error);
  }
}

async function updateFood(req, res, next) {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({
        status: "error",
        message: errors.array()[0].msg,
      });
    }

    const food = await Food.findByIdAndUpdate(req.params.id, req.body, {
      new: true,
    });
    if (!food) {
      return res.status(404).json({
        status: "error",
        message: "Food with this ID does not exist",
      });
    }
    res.status(200).json({
      status: "success",
      food,
    });
  } catch (error) {
    console.log(error);
  }
}

async function deleteFood(req, res, next) {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({
        status: "error",
        message: errors.array()[0].msg,
      });
    }

    const food = await Food.findByIdAndDelete(req.params.id);

    if (!food) {
      return res.status(404).json({
        status: "error",
        message: "Food with this ID does not exist",
      });
    }
    res.status(200).json({
      status: "success",
      food: null,
    });
  } catch (error) {
    console.log(error);
  }
}

module.exports = {
  getOneFood,
  getAllFoods,
  updateFood,
  deleteFood,
  createFood,
};
