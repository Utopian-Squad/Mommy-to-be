const express = require("express")
const router = express.Router();

const momController = require("../controllers/momController")

router.get("/",momController.getAllMoms);

router.get("/:id",momController.getOneMom);

router.post("/",momController.createMom);

router.put("/:id", momController.updateMom);

router.delete("/:id",momController.deleteMom);

module.exports = {
    router
}