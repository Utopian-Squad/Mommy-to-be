// const mongoose = require("mongoose");

// const userSchema = new mongoose.Schema({
//     name: {
//         type:String,
//         required: 'Name is required'
//     },
//     email:{
//         type:String,
//         required:'Email is required'
//     },
//     password:{
//         type:String,
//         required:'Password is required'
//     }
// }, {
//     timestamps:true
// });

// module.exports = mongoose.model("User",userSchema);
const mongoose=require("mongoose");
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
      type: mongoose.Schema.Types.ObjectId,
      ref: "BloodType",
    },
    role: {
      type:String,
      enum:["mom","nurse","admin"],
        default:"mom"
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
