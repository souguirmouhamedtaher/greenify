const User = require('../models/userModel');

exports.checkPhoneNumberExists = async (req, res) => {
    const { phoneNumber } = req.query;
    try {
        const user = await User.findOne({ phoneNumber });
        res.json({ exists: user ? true : false });
    } catch (e) {
        res.status(500).json({ message: e.message });
    }
};