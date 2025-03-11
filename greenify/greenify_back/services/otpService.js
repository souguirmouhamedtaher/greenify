const Otp = require('../models/otpModel');
const User = require('../models/userModel');


//delete OTP
exports.deleteOTP = async (req, res) => {
    const { phoneNumber } = req.body;
  
    try {
      await Otp.deleteMany({ phoneNumber }); // Delete all OTPs for this phone number
      res.status(200).json({ success: true });
    } catch (e) {
      res.status(400).json({ success: false, error: e.message });
    }
  };

// Store OTP
exports.storeOTP = async (req, res) => {
  const { phoneNumber, email, otp, expirationTime } = req.body;

  try {
    const newOtp = new Otp({
      phoneNumber,
      email,
      otp,
      expirationTime,
    });
    await newOtp.save();
    res.status(200).json({ success: true });
  } catch (e) {
    res.status(400).json({ success: false, error: e.message });
  }
};

// Verify OTP
exports.verifyOTP = async (req, res) => {
  const { phoneNumber, otp } = req.body;

  try {
    const otpRecord = await Otp.findOne({ phoneNumber });

    if (!otpRecord) {
      throw new Error('OTP not found.');
    }

    if (otpRecord.otp !== otp) {
      throw new Error('Invalid OTP.');
    }

    if (otpRecord.expirationTime < new Date()) {
      throw new Error('OTP has expired.');
    }

    // Update the user's email
    const user = await User.findOneAndUpdate(
      { phoneNumber },
      { email: otpRecord.email },
      { new: true },
    );

    if (!user) {
      throw new Error('User not found.');
    }

    // Delete the OTP record
    await Otp.deleteOne({ phoneNumber });

    res.status(200).json({ success: true });
  } catch (e) {
    res.status(400).json({ success: false, error: e.message });
  }
};