const { body } = require("express-validator");

/**
 *
 * @param {String} type
 * LOGIN | SIGNUP
 */
exports.validate = (type) => {
  switch (type) {
    case "LOGIN":
      return [
        body("email")
          .not()
          .isEmpty()
          .withMessage("Email is required"),
          body('email').isEmail().withMessage("Incorrect email."),
        body("password").not().isEmpty().withMessage("Password is required"),
      ];
    case "SIGNUP":
      return [
        body("email")
        .not()
        .isEmpty()
        .withMessage("Email is required"),
        body('email').isEmail().withMessage("Incorrect email."),
        body("firstName").not().isEmpty().withMessage("First Name is required"),
        body("lastName").not().isEmpty().withMessage("Last Name is required"),
        body("password").not().isEmpty().withMessage("Password is required"),
      ];
    default:
      return [];
  }
};
