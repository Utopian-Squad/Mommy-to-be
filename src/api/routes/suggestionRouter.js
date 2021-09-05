const express = require("express")
const router = express.Router();

const suggestionController = require("../controllers/suggestionController")

router.get("/",suggestionController.getAllSuggestions);

router.get("/:id",suggestionController.getOneSuggestion);

router.post("/",suggestionController.createSuggestion);

router.patch("/:id", suggestionController.updateSuggestion);

router.get("/random",suggestionController.randomSuggestion);

router.delete("/:id",suggestionController.deleteSuggestion);

module.exports = {
    router
}