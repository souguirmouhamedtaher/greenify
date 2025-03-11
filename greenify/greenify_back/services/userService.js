const User = require('../models/userModel');



const createUser = async (req, res) => {
  const userData = req.body;

  try {
    const user = new User(userData);
    await user.save();
    console.log("user created successfully")
    res.status(200).json({ success: true }); 
  } catch (e) {
    console.error("Error creating user:", e);
    res.status(400).json({ success: false, error: e.message }); 
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