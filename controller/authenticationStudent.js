const asyncHandler = require("../middleware/async");
const db = require("../config/connectDB");
const errorResponse = require("../utils/errorResponse");
const util = require("util");
const { getSignedJwtToken } = require("../utils/auth");
const query = util.promisify(db.query).bind(db);

// @desc    Register
// @route   POST /api/v1/auth/register
// @access  Public
exports.registerStudents = asyncHandler(async (req, res, next) => {
  const year = await query(`SELECT * FROM year ORDER BY id DESC LIMIT 1`);

  let yearJson = Object.values(JSON.parse(JSON.stringify(year)))[0];

  if (yearJson == undefined) {
    return next(new errorResponse("Invalid credentials", 401));
  }

  let {
    id_std,
    prefix,
    first_name,
    last_name,
    phone,
    email,
    images_url,
    id_class,
  } = req.body;

  // Check Duplicate
  const rows = await query(
    "SELECT COUNT(*) as total FROM `students` WHERE `id_std` = ?",
    [id_std]
  );

  let resultArray = Object.values(JSON.parse(JSON.stringify(rows)));
  if (resultArray[0].total > 0) {
    return next(new errorResponse(`Duplicate field value entered`, 400));
  }

  try {
    db.query(
      "INSERT INTO `students`(`id_class`, `id_std`, `prefix`, `first_name`, `last_name`, `phone`, `email`, `images_url`, `id_year`) VALUES (?,?,?,?,?,?,?,?,?)",
      [
        id_class,
        id_std,
        prefix,
        first_name,
        last_name,
        phone,
        email,
        images_url,
        yearJson.id,
      ]
    );
  } catch (err) {
    console.log(err);
    return next(new errorResponse(`Insert Failed`, 400));
  }

  sendTokenResponse(id_std, 200, res);
});

// @desc    Login Admin
// @route   POST /api/v1/auth/login
// @access  Public
exports.loginStudents = asyncHandler(async (req, res, next) => {
  const { username, password } = req.body;

  if (!username || !password) {
    return next(
      new errorResponse("Please provide an username and password", 400)
    );
  }

  const user = await query(
    "SELECT `id_std`, `phone` FROM `students` WHERE `id_std` = ? AND `phone` = ?",
    [username, password]
  );

  let userJson = Object.values(JSON.parse(JSON.stringify(user)))[0];

  if (userJson == undefined) {
    return next(new errorResponse("Not Found User", 404));
  }

  sendTokenResponse(userJson.id_std, 200, res);
});

// @desc    Get current logged in user
// @route   GET /api/v1/auth/me
// @access  Private
exports.getMeStudents = asyncHandler(async (req, res, next) => {
  res.status(200).json({ success: true, data: req.user });
});

// @desc  sendTokenResponse
const sendTokenResponse = (uniqid, statusCode, res) => {
  const token = getSignedJwtToken(uniqid);

  const options = {
    expires: new Date(
      Date.now() + process.env.JWT_COOKIE_EXPIRE * 24 * 60 * 60 * 1000
    ),
    httpOnly: true,
  };

  res
    .status(statusCode)
    .cookie("token", token, options)
    .json({ success: true, token });
};
