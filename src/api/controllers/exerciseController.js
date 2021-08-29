const Exercise = require("../models/exerciseModel")

async function getOneExercise(req,res){
    try{
        const exercise=await Exercise.findById(req.params.id)
        if(exercise==null){
           res.send('Error ' + err )
       }else{
           res.json(exercise)}
   }catch(err){
       res.send('Error ' + err )
   }
}

async function getAllExercises(req,res){
    
    try{
            const exercises=await Exercise.find()
            res.json(exercises)
    }catch(err){
        res.send('Error ' + err )
    }
}

async function createExercise(req,res){
    const exercise=new Exercise({
        id:req.body.id,        
       name:req.body.name,
       type:req.body.type,
       duration:req.body.duration,
      decription:req.body.description,

   })

   try{
       const ex=await exercise.save()
       res.json(ex)
   }catch(err){
       
      res.send('Error' + err)
       //throw new CustomError(err)
   }    

}