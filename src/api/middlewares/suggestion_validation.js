const { body, param } = require("express-validator");
const mongoose = require("mongoose");

exports.validate = (type) => {
  switch (type) {
    case "GET":
      return [
        param("id")
          .custom((value) => {
            return mongoose.Types.ObjectId.isValid(value);
          })
          .withMessage("Invalid Suggestion ID"),
      ];
    case "CREATE":
      return [
        body("countdown").not().isEmpty().withMessage("Countdown is required"),
        body("symptoms").not().isEmpty().withMessage("Symptoms is required"),
        body("timeline").not().isEmpty().withMessage("Timeline is required"),
        body("description")
          .not()
          .isEmpty()
          .withMessage("Description is required"),
      ];
    case "UPDATE":
      return [
        param("id")
          .custom((value) => {
            return mongoose.Types.ObjectId.isValid(value);
          })
          .withMessage("Invalid Suggestion ID"),
      ];
    case "DELETE":
      return [
        param("id")
          .custom((value) => {
            return mongoose.Types.ObjectId.isValid(value);
          })
          .withMessage("Invalid Suggestion ID"),
      ];
  }
};
