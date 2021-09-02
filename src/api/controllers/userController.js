//Here we will handle the validation of the users
const jwt = require("jsonwebtoken");

const userModel = require("../models/userModel")
const { validationResult } = require("express-validator");

const getToken = (id) => {
    return jwt.sign({ id }, process.env.JWT_SECRET_KEY, {
      expiresIn: process.env.JWT_EXPIRES_IN,
    });
  };

async function getOneUser(req,res){
    try {
        const errors = validationResult(req);
        if (!errors.isEmpty()) {
          return res.status(400).json({
            status: "error",
            message: errors.array()[0].msg,
          });
        }
        const user = await userModel.findById(req.params.id);
        if (!user) {
          return res.status(404).json({
            status: "error",
            message: "User with this ID does not exist",
          });
        }
        if (user.isDeleted) {
          return res.status(404).json({
            status: "error",
            message: "userModel with this ID does not exist",
          });
        }
        res.status(200).json({
          status: "success",
          user,
        });
      } catch (error) {
        console.log(error);
      }
}

async function getAllUsers(req,res){
    try {
        const errors = validationResult(req);
        if (!errors.isEmpty()) {
          return res.status(400).json({
            status: "error",
            message: errors.array()[0].msg,
          });
        }
        const page = req.query.page * 1 || 1;
        const limit = req.query.limit * 1 || 10;
    
        const result = await userModel.paginate(
          { },
          {
            page,
            limit,
            sort: "-createdAt",
          }
        );
        res.status(200).json({
          status: "success",
          result,
        });
      } catch (error) {
        console.log(error);
      } 
}

async function updateUser(req,res){
    try {
        const errors = validationResult(req);
        if (!errors.isEmpty()) {
          return res.status(400).json({
            status: "error",
            message: errors.array()[0].msg,
          });
        }
        
        const user = await userModel.findByIdAndUpdate(req.params.id, req.body, {
          new: true,
        });
    
        if (!user) {
          return res.status(404).json({
            status: "error",
            message: "User with this ID does not exist",
          });
        }
        res.status(200).json({
          status: "success",
          user,
        });
      } catch (error) {
        console.log(error);
      }

}

async function deleteUser(req,res){
    try {
        const errors = validationResult(req);
        if (!errors.isEmpty()) {
          return res.status(400).json({
            status: "error",
            message: errors.array()[0].msg,
          });
        }
    
        const user = await userModel.findByIdAndDelete(req.params.id);
    
        if (!user) {
          return res.status(404).json({
            status: "error",
            message: "User with this ID does not exist",
          });
        }
        res.status(200).json({
          status: "success",
          user:null,
        });
      } catch (error) {
        console.log(error);
      }

}

async function login(req,res,next){
    try {
        const errors = validationResult(req);
        if (!errors.isEmpty()) {
          res.status(400).json({
            status: "error",
            message: errors.array()[0].msg,
          });
        }
    
        const user = await userModel.findOne({
          email: req.body.email,
        })
          .select("+password")
        if (
          !user ||
          !(await user.verifyPassword(req.body.password, user.password))
        ) {
          return res.status(401).json({
            status: "error",
            message: "Invalid email or password",
          });
        }
        const token = getToken(user._id);
        res.status(201).json({
          status: "success",
          token,
          user,
        });
      } catch (err) {
        console.log(err);
      } 
}

async function createUser(req,res,next){
    try {
        const errors = validationResult(req);
        if (!errors.isEmpty()) {
          return res.status(400).json({
            status: "error",
            message: errors.array()[0].msg,
          });
        }
    
        // z
        const user = await userModel.create({
          ...req.body,
        });
    
        const token = getToken(user._id);
        res.status(201).json({
          status: "success",
          token,
          user,
        });
      } catch (err) {
        //TODO: Handle Error
        console.log(err);
      }
}

module.exports = {
   getOneUser,
   getAllUsers,
   createUser,
   updateUser,
   deleteUser,
   login 
}