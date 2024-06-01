const mongoose = require("mongoose");

//it is just structure of user
const eventSCchema = mongoose.Schema({
  subjectName: {
    required: true,
    type: String,
    trim: true,
  },
  startDate: {
    required: true,
    type: String,
    trim: true,
  },
  endDate: {
    required: true,
    type: String,
    trim: true,
  },
  totalLects: {
    required: true,
    type: String,
    trim: true,
  },
  remaianingLect: {
    type: String,
    value: 0,
    trim: true,
  },
  totalDays: {
    required: true,
    type: [String],
    trim: true,
  },
});

//creating model for uerschema
const Event = mongoose.model("Event", eventSCchema);

module.exports = { Event, eventSCchema };
