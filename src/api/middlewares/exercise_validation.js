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
          .withMessage("Invalid Exercise ID"),
      ];
    case "CREATE":
      return [
        body("name").not().isEmpty().withMessage("Name is required"),
        body("type").not().isEmpty().withMessage("Type is required"),
        body("duration").not().isEmpty().withMessage("Duration is required"),
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
          .withMessage("Invalid Exercise ID"),
      ];
    case "DELETE":
      return [
        param("id")
          .custom((value) => {
            return mongoose.Types.ObjectId.isValid(value);
          })
          .withMessage("Invalid Exercise ID"),
      ];
  }
};
