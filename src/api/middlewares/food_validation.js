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
          .withMessage("Invalid Food ID"),
      ];
    case "CREATE":
      return [
        body("name").not().isEmpty().withMessage("Name is required"),
        body("type").not().isEmpty().withMessage("Type is required"),
        body("display").not().isEmpty().withMessage("Display is required"),
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
          .withMessage("Invalid Food ID"),
      ];
    case "DELETE":
      return [
        param("id")
          .custom((value) => {
            return mongoose.Types.ObjectId.isValid(value);
          })
          .withMessage("Invalid Food ID"),
      ];
  }
};
