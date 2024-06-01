const express = require("express");
const authRouter = express();
const User = require("../models/user");
const jwt = require("jsonwebtoken");
const auth = require("../middleware/auth");

authRouter.post("/api/signUp", async (req, res) => {
  try {
    const { name, email } = req.body;

    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res
        .status(400)
        .json({ msg: "User with same email already exists!" });
    }

    let user = new User({
      name,
      email,
    });
    user = await user.save();

    // const token = jwt.sign({ id: user._id }, "passwordKey");
    // console.log(token);
    // res.json({ token, ...user._doc });
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

authRouter.post("/api/login", async (req, res) => {
  try {
    const { email } = req.body;

    const user = await User.findOne({ email });
    if (!user) {
      return res.status(400).json({ msg: "User not found" });
    }

    const token = jwt.sign({ id: user._id }, "passwordKey");
    console.log(token);
    res.json({ token, ...user._doc });
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

authRouter.post("/api/tokenIsValid", async (req, res) => {
  try {
    const token = req.header("x-auth-token");
    if (!token) return res.json(false);
    const verified = jwt.verify(token, "passwordKey");
    if (!verified) return res.json(false);

    const user = await User.findById(verified.id);
    if (!user) return res.json(false);

    res.json(true);
  } catch (e) {
    res.status(500).json({ error: e.message });
    console.log(token);
  }
});

//get user data
authRouter.get("/", auth, async (req, res) => {
  console.log(req.user);
  const user = await User.findById(req.user);
  res.json({ ...user._doc, token: req.token });
});

module.exports = authRouter;
