const express = require("express");
const router = express.Router();
const {
  createProduct,
  getAllProduct,
  updateProduct,
  deleteProduct,
  getProductInStore,
  getProductsCate,
} = require("../controller/product");
// const { protectAdmin } = require("../utils/auth");
router.get("/", getAllProduct);
// router.use(protectAdmin);
router.post("/", createProduct);
router.get("/productCate", getProductsCate);

router
  .route("/store/:id")
  .get(getProductInStore)
  .put(updateProduct)
  .delete(deleteProduct);
module.exports = router;
