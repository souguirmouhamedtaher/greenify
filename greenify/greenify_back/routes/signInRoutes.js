const express = require('express');
const router = express.Router();
const signInController = require('../controllers/SignInController');

router.get('/checkPhoneNumberExists', signInController.checkPhoneNumberExists);

module.exports = router;