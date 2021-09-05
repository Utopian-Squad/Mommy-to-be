const User = require("../models/userModel");
const jwt = require("jsonwebtoken");
const { promisify } = require("util");

exports.verifyUser = async (req, res, next) => {
    try {
      let token = null;
      if (
        req.headers.authorization &&
        req.headers.authorization.startsWith("Bearer")
      ) {
        token = req.headers.authorization.split(" ")[1];
      }
  
      if (!token) {
        return res.status(401).json({
          status: "error",
          message: "You are not logged in",
        });
      }
  
      const { id } = await promisify(jwt.verify)(
        token,
        process.env.JWT_SECRET_KEY
      );
      console.log(id);
      const user = await User.findById(id);
      req.user = user;
  
      next();
    } catch (err) {
      //TODO: Handle Invalid Token, Expired Token
      return res.status(401).json({
        status: "error",
        message: "Your token expired",
      });
      console.log(err);
    }
  };
  exports.verifyRole = (roleName, permissionName, titleName) => {
    return async (req, res, next) => {
      try {
        if (!req.user) {
          return res.status(401).json({
            status: "error",
            message: "User Unauthorized",
          });
        }
  
        const roles = req.user.roles;
        // console.log(roles.includes({ roleName: "admin" }), roles);
  
        let isAllowed = false;
  
        roles.privileges.forEach((privilege) => {
          if (privilege.title == titleName) {
            if (privilege.permissions.includes(permissionName)) {
              isAllowed = true;
            }
          }
        });
  
        if (!isAllowed) {
          return res.status(401).json({
            status: "error",
            message: "Unauthorized user",
          });
        }
  
        next();
      } catch (error) {
        console.log(error);
      }
    };
  };