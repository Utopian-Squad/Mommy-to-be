const express = require("express")
const userValidation = require("../middlewares/user_validation");
const {verifyUser}  = require("../middlewares/authentication");

const router = express.Router();

const userController = require("../controllers/userController")

router.get("/",userController.getAllUsers);

router.get("/:id",userController.getOneUser);

router.post("/",userController.createUser);

router.put("/:id", userController.updateUser);

router.delete("/:id",userController.deleteUser);

router.get("/",verifyUser,userController.getAllUsers);

router.get("/:id",verifyUser,userController.getOneUser);

router.post("/signup",userValidation.validate("SIGNUP"),userController.createUser);
router.post("/login",userValidation.validate("LOGIN"),userController.login);

router.patch("/:id", verifyUser,userController.updateUser);

router.delete("/:id",verifyUser,userController.deleteUser);

module.exports = {
    router
}