const express = require("express");
const router = express.Router();
const {
  registerAdmin,
  loginAdmin,
  getMeAdmin,
  getAdmin,
  deleteAdmin,
} = require("../controller/authentication");
const { protectAdmin } = require("../utils/auth");

router.post("/register_admin", registerAdmin);
router.post("/login_admin", loginAdmin);
router.get("/me_admin", protectAdmin, getMeAdmin);
router.get("/all_admin", protectAdmin, getAdmin);
router.delete("/delete_admin/:id", protectAdmin, deleteAdmin);

module.exports = router;
