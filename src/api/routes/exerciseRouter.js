const express = require("express");
const exerciseController = require("../controllers/exerciseController");
const exerciseValidation = require("../middlewares/exercise_validation");
const { verifyUser } = require("../middlewares/authentication");
const uploadImage = require("../controllers/uploadImage");

const router = express.Router();

router
  .route("/")
  .get(verifyUser, exerciseController.getAllExercises)
  .post(
    verifyUser,
    uploadImage,
    exerciseValidation.validate("CREATE"),
    exerciseController.createExercise
  );

router.get(
  "/:id",
  verifyUser,
  exerciseValidation.validate("GET"),
  exerciseController.getOneExercise
);

router.patch(
  "/:id",
  verifyUser,
  uploadImage,
  exerciseValidation.validate("UPDATE"),
  exerciseController.updateExercise
);

router.delete(
  "/:id",
  verifyUser,
  exerciseValidation.validate("DELETE"),
  exerciseController.deleteExercise
);

module.exports = {
  router,
};
