const express = require("express");
const router = express.Router();
const {
  registerStudents,
  loginStudents,
  getMeStudents,
} = require("../controller/authenticationStudent");
const { protectStudents } = require("../utils/auth");

router.post("/register_students", registerStudents);
router.post("/login_students", loginStudents);
router.get("/me_students", protectStudents, getMeStudents);

module.exports = router;
