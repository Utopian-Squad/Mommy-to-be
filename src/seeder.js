const fs = require("fs");
const mongoose = require("mongoose");
const dotenv = require("dotenv");
const colors = require("colors");

dotenv.config();

const Exercise = require("./api/models/exerciseModel");
const Food = require("./api/models/foodModel");
const Role = require("./api/models/role");
const Suggestion = require("./api/models/Suggestionmodel");
const User = require("./api/models/userModel");


mongoose
  .connect("mongodb://localhost:27017/api", {
    useCreateIndex: true,
    useFindAndModify: true,
    useNewUrlParser: true,
    useUnifiedTopology: true,
  })
  .then(() => {
    console.log("Connected to the database successfully".green);
  });

const user = JSON.parse(
  fs.readFileSync(`${__dirname}/_data/user.json`, "utf-8")
);

const role = JSON.parse(
  fs.readFileSync(`${__dirname}/_data/role.json`, "utf-8")
);

const exercise = JSON.parse(
  fs.readFileSync(`${__dirname}/_data/exercise.json`, "utf-8")
);

const food = JSON.parse(
  fs.readFileSync(`${__dirname}/_data/food.json`, "utf-8")
);
const suggestion = JSON.parse(
  fs.readFileSync(`${__dirname}/_data/suggestion.json`, "utf-8")
);


const importData = async () => {
  try {
    await User.create(user);
    await Role.create(role);
    await Exercise.create(exercise);
    await Suggestion.create(suggestion);
    await Food.create(food);

    console.log("Data Imported...!".green.inverse);
    process.exit();
  } catch (error) {
    console.log(error);
  }
};

const deleteData = async () => {
  try {
    await User.deleteMany();
    await Role.deleteMany();
    await Exercise.deleteMany();
    await Food.deleteMany();
    await Suggestion.deleteMany();

    console.log("Data Removed".red.inverse);
    process.exit();
  } catch (error) {
    console.log(error);
  }
};

if (process.argv[2] === "-i") {
  importData();
} else if (process.argv[2] === "-d") {
  deleteData();
}