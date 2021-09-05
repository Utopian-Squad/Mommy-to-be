const express = require("express");
const { verifyUser } = require("../middlewares/authentication");
const suggestionValidation = require("../middlewares/suggestion_validation");
const suggestionController = require("../controllers/suggestionController");

const router = express.Router();

router
  .route("/")
  .get(verifyUser, suggestionController.getAllSuggestions)
  .post(
    verifyUser,
    suggestionValidation.validate("CREATE"),
    suggestionController.createSuggestion
  );

router.get(
  "/:id",
  verifyUser,
  suggestionValidation.validate("GET"),
  suggestionController.getOneSuggestion
);

router.patch(
  "/:id",
  verifyUser,
  suggestionValidation.validate("UPDATE"),
  suggestionController.updateSuggestion
);

router.delete(
  "/:id",
  verifyUser,
  suggestionValidation.validate("DELETE"),
  suggestionController.deleteSuggestion
);

module.exports = {
  router,
};
