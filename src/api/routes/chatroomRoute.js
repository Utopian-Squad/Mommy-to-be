const router = require("express").Router();
const {catchErrors} = require("../handlers/errorHandlers");
const chatroomController = require("../controllers/chatroomController");
const auth = require("../middlewares/auth");

//const { route } = require("../app");

router.post("/", catchErrors(chatroomController.createChatroom));

router.post("/",auth,catchErrors(chatroomController.createChatroom));

module.exports = router;
