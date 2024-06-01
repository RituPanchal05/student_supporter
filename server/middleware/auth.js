const jwt = require("jsonwebtoken");
const auth = async (req, res, next) => {
  try {
    const token = req.header("x-auth-token");
    if (!token)
      return res
        .status(401)
        .json({ msg: "You're unauthorized, access denied" });

    const verified = jwt.verify(token, "passwordKey");
    if (!verified)
      return res
        .status(401)
        .json({ msg: "Token verification failed, authorization failed" });

    req.user = verified.id;
    req.token = token;
    next();
    console.log(token);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

module.exports = auth;
