const express = require("express");
const subjectRouter = express();
const { Subject } = require("../models/subject");
const jwt = require("jsonwebtoken");
const auth = require("../middleware/auth");
const User = require("../models/user");

subjectRouter.post("/api/addSubject", auth, async (req, res) => {
  try {
    // Extract the token from the request headers
    const token = req.headers["x-auth-token"];

    // Decode the token to get the user ID or any other information you need
    const decoded = jwt.verify(token, "passwordKey");

    // Retrieve the user data from the database based on the user ID
    const user = await User.findById(decoded.id);

    console.log(user.id);

    // Check if the user exists
    if (!user) {
      return res.status(404).json({ error: "User not found" });
    }

    const { subjectName, startDate, endDate, totalLects, totalDays } = req.body;
    let subject = new Subject({
      subjectName,
      startDate,
      endDate,
      totalLects,
      totalDays,
      createdBy: user._id,
    });
    subject = await subject.save();
    res.json(subject);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

subjectRouter.put("/api/updateRemainingLectures", auth, async (req, res) => {
  try {
    const token = req.headers["x-auth-token"];
    const decoded = jwt.verify(token, "passwordKey");
    const user = await User.findById(decoded.id);

    if (!user) {
      return res.status(404).json({ error: "User not found" });
    }

    const { subjectName, remainingLects } = req.body;
    console.log(req.body);

    // Check if subjectName and remainingLects are provided
    if (!subjectName || !remainingLects) {
      return res
        .status(400)
        .json({ error: "Subject name and remaining lectures are required" });
    }

    // Find the subject by subjectName
    let subject = await Subject.findOne({ subjectName });

    // If subject is not found, return 404 error
    if (!subject) {
      return res.status(404).json({ error: "Subject not found" });
    }

    // Update the remainingLects field by adding the new value to the existing value
    subject.remainingLects = parseInt(subject.remainingLects) + remainingLects;

    // Save the updated document
    subject = await subject.save();
    console.log("Updated🤩");

    res.json(subject);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// Get all your products
subjectRouter.get("/api/get-subjects", auth, async (req, res) => {
  try {
    // Extract the user ID from the request object (assuming it was added by your authentication middleware)
    const userId = req.user.id;

    // Find all events added by the authenticated user
    const subjects = await Subject.find({ createdBy: userId });

    // Check if the user has not added any event
    if (subjects.length === 0) {
      return res.status(404).json({ message: "User has not added any events" });
    }

    res.json(subjects);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = subjectRouter;
