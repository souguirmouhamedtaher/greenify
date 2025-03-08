const express = require('express');
const router = express.Router();
const phoneNumber = require('../services/phoneNumberService');
const emailService = require('../services/emailServices');

router.get('/checkPhoneNumberExists', phoneNumber.checkPhoneNumberExists);
router.post('/sendOTP', emailService.sendOTP);
router.post('/verifyOTP', emailService.verifyOTP);
module.exports = router;