const User = require('../models/userModel');



const createUser = async (data = {name,foreName,email,password,birthDate,role,phoneNumber}) => {
    try {
      const existingUser = await User.findOne({ phoneNumber });
  
      if (existingUser) {
        throw new Error('User already exists');
      }
  
      const user = await User.create({ data });
      return user; 
    } catch (e) {
      throw new Error(`Error creating user: ${e.message}`);
    }
};


const findUserByPhoneNumber = async (phoneNumber) => {
  try {
    const user = await User.findOne({ phoneNumber });
    return user;
  } catch (e) {
    throw new Error(`Error finding user: ${e.message}`);
  }
};

const updateUserByPhoneNumber = async (phoneNumber, updateData) => {
  try {
    const user = await User.findOneAndUpdate(
      { phoneNumber }, 
      updateData, 
      { new: true }
    );

    if (!user) {
      throw new Error('User not found');
    }

    return user; 
  } catch (e) {
    throw new Error(`Error updating user: ${e.message}`);
  }
};

module.exports = { createUser ,updateUserByPhoneNumber ,findUserByPhoneNumber };