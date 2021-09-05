const express = require("express")
const mongoose = require("mongoose");
const dotenv = require("dotenv");
const morgan = require("morgan");
const path = require("path");
const cors = require("cors");
dotenv.config();


const userRouter = require("./src/api/routes/userRoute")
const momRouter = require("./src/api/routes/momRoute")
const nurseRouter = require("./src/api/routes/nurseRoute")
const adminRouter = require("./src/api/routes/adminRouter")
const foodRouter = require("./src/api/routes/foodRoute")
const exerciseRouter = require("./src/api/routes/exerciseRouter")
const suggestionRouter = require("./src/api/routes/suggestionRouter")
const notificationRouter = require("./src/api/routes/notificationRouter");
const chatRouter = require("./src/api/routes/chatroomRoute")

const app = express()

if (process.env.NODE_ENV == "DEVELOPMENT") {
    app.use(morgan("dev"));
  }
  app.use(cors());
  app.use(express.json());
  app.use(express.static(path.join(__dirname, "../public")));


app.use("/api/login",userRouter.router);
app.use("/api/user/mom",momRouter.router);
app.use("/api/user/nurse",nurseRouter.router);
app.use("/api/admin",adminRouter.router);
app.use("/api/user/food",foodRouter.router);
app.use("/api/user/exercise",exerciseRouter.router);
app.use("/api/user/suggestion",suggestionRouter.router);
app.use("/api/user/notification",notificationRouter.router);
app.use("/api/user/chatroom",chatRouter.router);


app.listen("3000",(err)=>{

    if (err){
        console.log(err);
        process.exit(1);
    }

require("./src/api/utils/db/db")

    console.log("app is running on port 3000");
})


