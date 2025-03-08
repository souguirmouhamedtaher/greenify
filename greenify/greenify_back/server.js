const express = require('express');
const dotenv = require('dotenv');
const connectDB = require('./config/db');
const signInRoutes = require('./routes/signInRoutes');

dotenv.config();
connectDB();
const app = express();
app.use(express.json());
app.use('/api/signup', signInRoutes);

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));