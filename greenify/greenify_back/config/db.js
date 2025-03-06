const mongoose = require('mongoose');

const connectDB = async () => {
    try{
        await mongoose.connect(process.env.database_uri);
        console.log('MongoDB connected');
    }
    catch(e){
        console.error(e);
    }
};

module.exports = connectDB;