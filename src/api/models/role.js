const mongoose = require("mongoose");
const bcrypt = require("bcrypt");
const mongoosePaginate = require("mongoose-paginate");

const schema = new mongoose.Schema(
    {
      roleName: {
        type: String,
      },
      privileges: {
        type: [
          {
            title: { type: String },
            permissions: {
              type: [],
              default: ["read", "create", "update", "delete"],
            },
          },
        ],
      },
      createdBy: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "User",
      },
      isDeleted: {
        type: Boolean,
        default: false,
      },
    },
    {
      timestamps: true,
    }
  );
  
  schema.plugin(mongoosePaginate);
  
  const Role = mongoose.model("Role", schema);
  
  module.exports = Role;