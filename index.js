const express = require("express")
const app = express()

const userRouter = require("./src/api/routes/userRoute")
const momRouter = require("./src/api/routes/momRoute")
const nurseRouter = require("./src/api/routes/nurseRoute")
const adminRouter = require("./src/api/routes/adminRouter")
const foodRouter = require("./src/api/routes/foodRoute")
const exerciseRouter = require("./src/api/routes/exerciseRouter")
const suggestionRouter = require("./src/api/routes/suggestionRouter")
const notificationRouter = require("./src/api/routes/notificationRouter");



app.use("/api/login",userRouter.router);
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

require("./src/api/utils/db/db")

    console.log("app is running on port 3000");
})


