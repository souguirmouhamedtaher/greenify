const express = require('express');
const router = express.Router();
const pns = require('../services/phoneNumberService');
const es = require('../services/emailServices');
const us = require('../services/userService');

router.get('/checkPhoneNumberExists', pns.checkPhoneNumberExists);
router.get('/checkEmailExists', es.checkEmailExists);
router.post('/createUser',us.createUser);
module.exports = router;