const asyncHandler = require("../middleware/async");
const db = require("../config/connectDB");
const errorResponse = require("../utils/errorResponse");
const path = require("path");
const util = require("util");
const query = util.promisify(db.query).bind(db);

exports.getProductInStore = asyncHandler(async (req, res, next) => {
  let sql = `SELECT * FROM product WHERE id_store = ${req.params.id}`;

  const user = await query(sql);

  let userJson = Object.values(JSON.parse(JSON.stringify(user)));

  if (userJson == undefined) {
    return next(new errorResponse("Invalid credentials", 401));
  }

  res.status(200).json({ success: true, data: userJson });
});

exports.getProductsCate = asyncHandler(async (req, res, next) => {
  let sql = "SELECT * FROM `product_category`";
  const user = await query(sql);

  let userJson = Object.values(JSON.parse(JSON.stringify(user)));

  if (userJson == undefined) {
    return next(new errorResponse("Invalid credentials", 401));
  }

  res.status(200).json({ success: true, data: userJson });
});

exports.createProduct = asyncHandler(async (req, res, next) => {
  const { product_name, detail, price, unit, id_store, id_product_cate } =
    req.body;
  let user;

  // console.log(req.body.id_std);
  let checkQuery;
  checkQuery = await query(
    `SELECT COUNT(*) as cpu FROM product WHERE product_name = ?`,
    [product_name]
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
      "INSERT INTO `product` (`product_name`, `detail`, `price`, `unit`, `id_store`, `id_product_cate`) VALUES (?,?,?,?,?,?);",
      [product_name, detail, price, unit, id_store, id_product_cate]
    );
  } catch (err) {
    return next(new errorResponse(`Insert Failed`, 400));
  }
  res.status(200).json({ success: true, storeId: user.insertId });
});

exports.updateProduct = asyncHandler(async (req, res, next) => {
  const { product_name, detail, price, unit, id_product_cate } = req.body;

  try {
    await db.query(
      "UPDATE `product` SET `product_name`=?,`detail`=?,`price`=?,`unit`=?,`id_product_cate`=? WHERE `id` = ?",
      [product_name, detail, price, unit, id_product_cate ,req.params.id]
    );
  } catch (err) {
    return next(new errorResponse(`Update Failed`, 400));
  }

  const user = await query(`SELECT * FROM product WHERE id = ?`, [req.params.id]);

  let userJson = Object.values(JSON.parse(JSON.stringify(user)))[0];

  if (userJson == undefined) {
    return next(new errorResponse("Invalid credentials", 401));
  }

  res.status(200).json({ success: true, data: userJson });
});

exports.deleteProduct = asyncHandler(async (req, res, next) => {
  try {
    db.query("DELETE FROM `product` WHERE `id` = ? ", [req.params.id]);
  } catch (err) {
    return next(new errorResponse(`Delete Failed`, 400));
  }

  res.status(200).json({ success: true, data: {} });
});

exports.getAllProduct= asyncHandler(async (req, res, next) => {
    let sql = `SELECT * FROM product ORDER BY id DESC`;
  
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