const User = require('../models/userModel');

exports.checkEmailExists = async (req, res) => {
    const { email } = req.query;
    try {
        const user = await User.findOne({ email });
        res.json({ exists: user ? true : false });
    } catch (e) {
        res.status(500).json({ message: e.message });
    }
};