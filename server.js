const express = require("express");
const dotenv = require("dotenv");
const colors = require("colors");
const cors = require("cors");
const path = require("path");
const fileupload = require("express-fileupload");
const errorHandle = require("./middleware/error");
const xss = require("xss-clean");
const helmet = require("helmet");
const hpp = require("hpp");

//-------------- SETUP ---------------
// Load ENV
dotenv.config({ path: "./config/config.env" });

// Router
// const authAdmin = require("./router/authentication");
// const authStd = require("./router/authenticationStudent");
const store = require("./router/store");
const product = require("./router/product");

// Setup Express
const app = express();

// middleware
app.use(express.json());
app.use(cors());
app.use(xss());
app.use(hpp());
app.use(helmet());
app.use(express.static(path.join(__dirname, "public")));
app.use(fileupload());
//-----------------------------------------

// --------------- ROUTER -----------------
// app.use("/api/v1/auth", authAdmin);
// app.use("/api/v1/auth_std", authStd);
app.use("/api/v1/store", store);
app.use("/api/v1/product", product);

app.use(errorHandle);
// ---------------------------------------

// -------------- SERVER ----------------
const PORT = 5001;

const server = app.listen(PORT, () => {
  console.log(`App listening on port ${PORT}`.black.bgGreen);
});

process.on("unhandledRejection", (err, promise) => {
  console.log(`Error: ${err.message}`.bgRed);
  server.close(() => process.exit(1));
});
// --------------------------------------
