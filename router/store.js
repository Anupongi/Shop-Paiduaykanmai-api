const express = require("express");
const router = express.Router();
const {
  createStore,
  getStore,
  getSingleStore,
  // deleteCandidate,
  updateStore
} = require("../controller/store");
router.get("/",getStore)
router.post("/",createStore);
router
  .route("/:id")
  .get(getSingleStore)
  .put(updateStore)
  // .delete(deleteCandidate);
module.exports = router;