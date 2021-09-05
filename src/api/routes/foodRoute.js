const express = require("express");
const { verifyUser } = require("../middlewares/authentication");
const uploadImage = require("../controllers/uploadImage");
const foodValidation = require("../middlewares/food_validation");
const foodController = require("../controllers/foodController");

const router = express.Router();

router
  .route("/")
  .get(verifyUser, foodController.getAllFoods)
  .post(
    verifyUser,
    uploadImage,
    foodValidation.validate("CREATE"),
    foodController.createFood
  );

router
  .route("/:id")
  .get(verifyUser, foodValidation.validate("GET"), foodController.getOneFood)
  .patch(
    verifyUser,
    foodValidation.validate("UPDATE"),
    foodController.updateFood
  )
  .delete(
    verifyUser,
    foodValidation.validate("DELETE"),
    foodController.deleteFood
  );

module.exports = {
  router,
};
