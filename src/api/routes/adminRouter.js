const express = require("express")
const router = express.Router();

const adminController = require("../controllers/adminController")

router.get("/",adminController.getAllUsers);

router.get("/:id",adminController.getOneUser);

router.post("/",adminController.createRole);

router.put("/:id", adminController.updateRole);

router.delete("/:id",adminController.deleteRole);

module.exports = {
    router
}