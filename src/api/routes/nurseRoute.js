const express = require("express")
const router = express.Router();

const nurseController = require("../controllers/nurseController")

router.get("/",nurseController.getAllNurses);

router.get("/:id",nurseController.getOneNurse);

router.post("/",nurseController.createNurse);

router.put("/:id", nurseController.updateNurse);

router.delete("/:id",nurseController.deleteNurse);

module.exports = {
    router
}