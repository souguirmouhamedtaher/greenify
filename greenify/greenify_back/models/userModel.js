const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
  name:{type:String, required:true},
  foreName:{type:String, required:true},
  email:{type:String,unique:true},
  password:{type:String, required:true},
  birthDate:{type:Date,required:true},
  role:{type:String,required:true,enum:['farmer','employee','admin'],default:'farmer'},
  isGreenified:{type:Boolean,required:true,default : false},
  phoneNumber:{type:String,required:true}
});     

module.exports = mongoose.model('User', userSchema);