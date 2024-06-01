const express = require("express");
const eventRouter = express();
const { Event } = require("../models/events");
const jwt = require("jsonwebtoken");
const auth = require("../middleware/auth");
const User = require("../models/user");

eventRouter.post("/api/addevent", auth, async (req, res) => {
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

    const {
      subjectName,
      startDate,
      endDate,
      totalLects,
      totalDays,
      remaianingLect,
    } = req.body;
    let event = new Event({
      subjectName,
      startDate,
      endDate,
      totalLects,
      totalDays,
      remaianingLect,
      createdBy: user._id,
    });
    event = await event.save();
    res.json(event);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

eventRouter.post("/api/updateLects", auth, async (req, res) => {
  try {
    const token = req.headers["x-auth-token"];
    const decoded = jwt.verify(token, "passwordKey");
    const user = await User.findById(decoded.id);

    if (!user) {
      return res.status(404).json({ error: "User not found" });
    }

    const { subjectName, remainingLects } = req.body;

    if (!subjectName || !remainingLects) {
      return res
        .status(400)
        .json({ error: "Subject name and remaining lectures are required" });
    }

    let event = await Event.findOne({ subjectName, createdBy: user._id });

    if (event) {
      event.remainingLects =
        parseInt(event.remainingLects) + parseInt(remainingLects);
      event = await event.save();
      res.json(event);
    } else {
      res.status(404).json({ error: "Event not found" });
    }
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// Get all your products
eventRouter.get("/api/get-events", auth, async (req, res) => {
  try {
    // Extract the user ID from the request object (assuming it was added by your authentication middleware)
    const userId = req.user.id;

    // Find all events added by the authenticated user
    const events = await Event.find({ createdBy: userId });

    // Check if the user has not added any event
    if (events.length === 0) {
      return res.status(404).json({ message: "User has not added any events" });
    }

    res.json(events);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = eventRouter;
