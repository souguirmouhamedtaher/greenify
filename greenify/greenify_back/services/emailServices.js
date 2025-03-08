// services/emailService.js
const Otp = require('../models/otpModel');
const sgMail = require('@sendgrid/mail');
const {sendGridApiKey  } = require('../utils/constants');
const User = require('../services/userService');
sgMail.setApiKey(sendGridApiKey);

function generateOTP  ()  {
    return Math.floor(1000 + Math.random() * 9000).toString();
  };

const sendOTP = async (email, phoneNumber) => {
  const otp = generateOTP();

  await Otp.create({ email,phoneNumber, otp });

  const msg = {
    to: email,
    from: "souguir.mouhamed.taher.work@gmail.com",
    subject: "Code de verification de votre compte",
    text: EMAIL_TEXT(otp),
  };

  try {
    await sgMail.send(msg);
    console.log('OTP sent successfully');
  } catch (error) {
    console.error('Error sending OTP:', error);
    throw new Error('Failed to send OTP');
  }
};

const verifyOTP = async (phoneNumber, otp) => {
  const otpRecord = await Otp.findOne({ phoneNumber, otp });
  if (!otpRecord) {
    throw new Error('Invalid OTP');
  }
  await User.updateUserByPhoneNumber(phoneNumber, { email : otpRecord.email , isGreenified: true });
  await Otp.deleteOne({ phoneNumber, otp });
  return true;
};

module.exports = { sendOTP, verifyOTP };