const asyncHandler = require("../middleware/async");
const db = require("../config/connectDB");
const errorResponse = require("../utils/errorResponse");
const path = require("path");
const util = require("util");
const query = util.promisify(db.query).bind(db);

// @desc    create Candidate
// @route   POST /api/v1/candidate/
// @access  Private
exports.createStore = asyncHandler(async (req, res, next) => {
  const { store_name, detail, phone_number, address } = req.body;
  let user;

  // console.log(req.body.id_std);
  let checkQuery;
  checkQuery = await query(
    `SELECT COUNT(*) as cpu FROM store WHERE store_name = ?`,
    [store_name]
  );

  let userJson = Object.values(JSON.parse(JSON.stringify(checkQuery)))[0];

  if (userJson == undefined) {
    return next(new errorResponse("Invalid credentials", 401));
  }

  if (userJson.cpu > 1) {
    return next(new errorResponse("ข้อมูลนี้ซ้ำ", 401));
  }
  try {
    user = await query(
      "INSERT INTO `store` (`store_name`, `detail`, `phone_number`, `address`) VALUES (?,?,?,?);",
      [store_name, detail, phone_number, address]
    );
  } catch (err) {
    return next(new errorResponse(`Insert Failed`, 400));
  }
  res.status(200).json({ success: true, storeId: user.insertId });
});

// @desc    get Single Player
// @route   GET /api/v1/player/:id
// @access  Private
exports.getSingleStore = asyncHandler(async (req, res, next) => {
  const user = await query(`SELECT * FROM store WHERE id = ? ORDER BY id DESC`, [req.params.id]);

  let userJson = Object.values(JSON.parse(JSON.stringify(user)))[0];

  if (userJson == undefined) {
    return next(new errorResponse("Invalid credentials", 401));
  }

  res.status(200).json({ success: true, data: userJson });
});

// @desc    get All Player
// @route   GET /api/v1/player/
// @access  Private
exports.getStore = asyncHandler(async (req, res, next) => {
  let sql = `SELECT * FROM store ORDER BY id DESC`;

  // if (req.query.id_year) {
  //   sql += `WHERE candidate.id_year = ${req.query.id_year}`;
  // }
  const user = await query(sql);

  let userJson = Object.values(JSON.parse(JSON.stringify(user)));

  if (userJson == undefined) {
    return next(new errorResponse("Invalid credentials", 401));
  }

  res.status(200).json({ success: true, data: userJson });
});

// @desc    Update Player Detail
// @route   PUT /api/v1/player/:id
// @access  Private
exports.updateStore = asyncHandler(async (req, res, next) => {
  const { store_name, detail, phone_number, address } = req.body;

  try {
    await db.query(
      "UPDATE `store` SET `store_name`=?,`detail`=?,`phone_number`=?,`address`=? WHERE `id` = ?",
      [store_name, detail, phone_number, address, req.params.id]
    );
  } catch (err) {
    return next(new errorResponse(`Update Failed`, 400));
  }

  const user = await query(
    `SELECT * FROM store WHERE id = ?`,
    [req.params.id]
  );

  let userJson = Object.values(JSON.parse(JSON.stringify(user)))[0];

  if (userJson == undefined) {
    return next(new errorResponse("Invalid credentials", 401));
  }

  res.status(200).json({ success: true, data: userJson });
});

