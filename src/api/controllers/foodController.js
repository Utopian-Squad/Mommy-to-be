const Food = require("../models/foodModel")

async function getOneFood(req,res){
    try{
        const food=await Food.findById(req.params.id)
        if(food==null){
           res.send('Error ' + err )
       }else{
           res.json(food)}
   }catch(err){
       res.send('Error ' + err )
   }

}

async function getAllFoods(req,res){
    try{
        const foods=await Food.find()
        res.json(foods)
   }catch(err){
       res.send('Error' + err )
   }
}

async function createFood(req,res){
    const food=new Food({
        id:req.body.id,        
       name:req.body.name,
       type:req.body.type,
      decription:req.body.description,

   })

   try{
       const fd=await food.save()
       res.json(fd)
   }catch(err){
       
      res.send('Error' + err)
   }

}

async function updateFood(req,res){
    try{
        const food=await Food.findById(req.params.id)
        console.log(req.params)
        food.sub=req.body.sub
        
        const fd=await food.save()
        res.json(fd)
    }catch(err){
        res.send('Error' + err)
    }

}

async function deleteFood(req,res){

    try{
        const food=await Food.findById(req.params.id)
        food.sub=req.body.sub
        const fd=await food.remove()
        res.json(fd)
    }catch(err){
       res.send('Error' + err)
    }
}

module.exports = {
   getOneFood,
   getAllFoods,
   createFood,
   updateFood,
   deleteFood 
}
