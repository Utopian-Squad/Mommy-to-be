
const express = require("express")
const mongoose = require("mongoose");
const dotenv = require("dotenv");
const morgan = require("morgan");
const path = require("path");
const cors = require("cors");
dotenv.config();


const userRouter = require("./api/routes/userRoute")
const momRouter = require("./api/routes/momRoute")
const nurseRouter = require("./api/routes/nurseRoute")
const adminRouter = require("./api/routes/adminRouter")
const foodRouter = require("./api/routes/foodRoute")
const exerciseRouter = require("./api/routes/exerciseRouter")
const suggestionRouter = require("./api/routes/suggestionRouter")
const notificationRouter = require("./api/routes/notificationRouter");

const app = express()

if (process.env.NODE_ENV == "DEVELOPMENT") {
    app.use(morgan("dev"));
  }
  app.use(cors());
  app.use(express.json());
  app.use(express.static(path.join(__dirname, "../public")));

app.use("/api/users",userRouter.router);
app.use("/api/mom",momRouter.router);
app.use("/api/nurse",nurseRouter.router);
app.use("/api/admin",adminRouter.router);
app.use("/api/food",foodRouter.router);
app.use("/api/exercise",exerciseRouter.router);
app.use("/api/suggestion",suggestionRouter.router);
app.use("/api/notification",notificationRouter.router);


app.listen("3000",(err)=>{

    if (err){
        console.log(err);
        process.exit(1);
    }

    require("./api/utils/db/db")

    console.log("app is running on port 3000");
});
