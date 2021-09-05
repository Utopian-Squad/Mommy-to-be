const mongoose = require("mongoose");
const bcrypt = require("bcrypt");
const mongoosePaginate = require("mongoose-paginate");

const schema = new mongoose.Schema(
  {
    firstName: {
      type: String,
    },
    lastName: {
      type: String,
    },
    email: {
      type: String,
    },
    image: {
      type: String,
      default: "default.png",
    },
    address: {
      type: {
        state: {
          type: String,
        },
        city: {
          type: String,
        },
        woreda: {
          type: String,
        },
      },
    },
    dateOfBirth: {
      type: String,
    },

    password: {
      type: String,
      select: false,
    },
    bloodType: {
      type: String,
    },
    conceivingDate: {
      type:String,
    },
    cv:{
      type:String,
    },
    gender:{
      type:String
    },
    phoneNumber:{
      type:String
    },
    isDeleted:{
      type:Boolean,
      default:false
    },
    roles: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Role",
    },
  },
  {
    timestamps: true,
  }
);

schema.pre("save", async function (next) {
  if (this.isModified("password")) {
    this.password = await bcrypt.hash(this.password, 10);
  }
  next();
});

schema.methods.verifyPassword = async function (
  candidatePassword,
  userPassword
) {
  return await bcrypt.compare(candidatePassword, userPassword);
};

schema.plugin(mongoosePaginate);
// schema.methods.

const User = mongoose.model("User", schema);

module.exports = User;
