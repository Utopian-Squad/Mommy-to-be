const express = require("express");
const mongoose = require("mongoose");
const dotenv = require("dotenv");
const morgan = require("morgan");
const path = require("path");
const cors = require("cors");
dotenv.config();

const userRouter = require("./api/routes/userRoute");
const foodRouter = require("./api/routes/foodRoute");
const exerciseRouter = require("./api/routes/exerciseRouter");
const suggestionRouter = require("./api/routes/suggestionRoute");
const roleRouter = require("./api/routes/role");
// const chatRouter = require("./src/api/routes/chatroomRoute");

const app = express();

if (process.env.NODE_ENV == "DEVELOPMENT") {
  app.use(morgan("dev"));
}
app.use(cors());
app.use(express.json());
app.use(express.static(path.join(__dirname, "./api/public")));

app.use("/api/v1/user", userRouter.router);
app.use("/api/v1/food", foodRouter.router);
app.use("/api/v1/exercise", exerciseRouter.router);
app.use("/api/v1/suggestion", suggestionRouter.router);
app.use("/api/v1/role",roleRouter.router);
// app.use("/api/user/chatroom",chatRouter.router);

app.listen("3000", (err) => {
  if (err) {
    console.log(err);
    process.exit(1);
  }

  require("./api/utils/db/db");

  console.log("app is running on port 3000");
});


// const io = require("socket.io")(server, {
//   allowEIO3: true,
//   cors: {
//     origin: true,
//     methods: ['GET', 'POST'],
//     credentials: true
//   }
// });

// const jwt = require("jwt-then");

// const Message = mongoose.model("Message");
// const User = mongoose.model("User");

// io.use(async (socket, next) => {
//   try {
//     const token = socket.handshake.query.token;
//     const payload = await jwt.verify(token, process.env.SECRET);
//     socket.userId = payload.id;
//     next();
//   } catch (err) {}
// });

// io.on("connection", (socket) => {
//   console.log("Connected: " + socket.userId);

//   socket.on("disconnect", () => {
//     console.log("Disconnected: " + socket.userId);
//   });

//   socket.on("joinRoom", ({ chatroomId }) => {
//     socket.join(chatroomId);
//     console.log("A user joined chatroom: " + chatroomId);
//   });

//   socket.on("leaveRoom", ({ chatroomId }) => {
//     socket.leave(chatroomId);
//     console.log("A user left chatroom: " + chatroomId);
//   });

//   socket.on("chatroomMessage", async ({ chatroomId, message }) => {
//     if (message.trim().length > 0) {
//       const user = await User.findOne({ _id: socket.userId });
//       const newMessage = new Message({
//         chatroom: chatroomId,
//         user: socket.userId,
//         message,
//       });
//       io.to(chatroomId).emit("newMessage", {
//         message,
//         name: user.name,
//         userId: socket.userId,
//       });
//       await newMessage.save();
//     }
//   });
// });
