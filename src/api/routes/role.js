const express = require("express");
const roleController = require("../controllers/role");
const roleValidation = require("../middlewares/role");
const { verifyUser, verifyRole } = require("../middlewares/authentication");

const router = express.Router();

router
  .route("/")
  .get(
    verifyUser,
    roleController.getAllRoles
  )
  .post(
    verifyUser,
    roleValidation.validate("CREATE"),
    roleController.createRole
  );

  
  router
  .route("/:id")
  .get(
      verifyUser,
      roleValidation.validate("GET"),
      roleController.getRole
      )
      .patch(
          verifyUser,
          roleValidation.validate("UPDATE"),
          roleController.updateRole
          )
          .delete(
              verifyUser,
              roleValidation.validate("DELETE"),
              roleController.deleteRole
              );
              
              router.route("/:roleName").get(roleController.getRoleByName);
              module.exports = {
                router
            }