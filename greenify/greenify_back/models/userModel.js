const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
  userType:{type:String,required:true,enum:['farmer','employee','admin'],default:'farmer'},
  name:{type:String, required:true},
  foreName:{type:String, required:true},
  email:{type:String,unique:true},
  phoneNumber:{type:String,required:true},
  password:{type:String, required:true},
  isGreenified:{type:Boolean,default : false},
  birthDate:{type:Date,required:true},
  profilePicture:{type:String},


});     

module.exports = mongoose.model('User', userSchema);