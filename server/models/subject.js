const mongoose = require("mongoose");

//it is just structure of user
const subjectSchema = mongoose.Schema({
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
  attendedLects: {
    type: String,
    default: 10,
    trim: true,
  },
  remainingLects: {
    type: String,
    default: "",
    trim: true,
  },
  totalAttendence: {
    type: String,
    default: 0,
    trim: "true",
  },
  remainingAttendence: {
    type: String,
    default: 0,
    trim: true,
  },
  totalDays: {
    required: true,
    type: [String],
    trim: true,
  },
});

//creating model for uerschema
const Subject = mongoose.model("Subject", subjectSchema);

module.exports = { Subject, subjectSchema };
