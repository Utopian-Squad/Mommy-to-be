//Here we will handle the validation of the users
const jwt = require("jsonwebtoken");

const userModel = require("../models/userModel");
const { validationResult } = require("express-validator");
const Role = require("../models/role");

const getToken = (id) => {
  return jwt.sign({ id }, process.env.JWT_SECRET_KEY, {
    expiresIn: process.env.JWT_EXPIRES_IN,
  });
};

async function getOneUser(req, res) {
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

async function getAllUsers(req, res) {
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
      {},
      {
        page,
        limit,
        sort: "-createdAt",
        populate:"roles"
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

async function updateUser(req, res) {
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

async function deleteUser(req, res) {
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
      user: null,
    });
  } catch (error) {
    console.log(error);
  }
}

async function login(req, res, next) {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({
        status: "error",
        message: errors.array()[0].msg,
      });
    }

    let user = await userModel
      .findOne({
        phoneNumber: req.body.phoneNumber,
        isDeleted:false,
      })
      .select("+password").populate("roles");
    if (
      !user ||
      !(await user.verifyPassword(req.body.password, user.password))
    ) {
      return res.status(401).json({
        status: "error",
        message: "Invalid email or password",
      });
    }
    user = await userModel.findById(user._id).populate("roles");
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

async function createUser(req, res, next) {
  try {
    console.log(req.body);
    console.log(req.files);
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({
        status: "error",
        message: errors.array()[0].msg,
      });
    }

    const userExisted = await userModel.findOne({ phoneNumber: req.body.phoneNumber });

    if (userExisted) {
      return res.status(400).json({
        status: "error",
        message: "Phone number already existed!",
      });
    }
    console.log(req);
    const defaultRole = await Role.findOne({ roleName: "mom" });
    if (!req.file) {
      req.file = { filename: "default_mom.png" };
    }
    
    let user = await userModel.create({
      ...req.body,
        roles:defaultRole._id,
        image:req.files[0]? req.files[0].filename:'',
        cv:req.files[1]? req.files[1].filename :""
    });
    user = await userModel.findById(user._id).populate("roles");
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
  login,
};
