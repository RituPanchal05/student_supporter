const express = require("express");
const app = express();
const mongoose = require("mongoose");
const cors = require("cors");
const PORT = 3000;

const authRouter = require("./routes/auth_user_route");
const eventRouter = require("./routes/events_Add");
const subjectRouter = require("./routes/subject_Add");

const DB =
  "mongodb+srv://ritupanchal05:ritu12345@cluster0.mnr5ild.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";

//MIDDLEWARES
app.use(express.json());
app.use(authRouter);
app.use(eventRouter);
app.use(subjectRouter);
app.use(cors({ origin: "*" }));
app.use(cors());

//Connecitons
mongoose
  .connect(DB)
  .then(() => {
    console.log("connected");
  })
  .catch((e) => {
    console.log(e);
  });

app.listen(PORT, (req, res) => {
  console.log(`Server is listeinin at ${PORT}`);
});
