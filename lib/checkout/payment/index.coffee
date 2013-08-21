express = require "express"
app = module.exports = express()
app.set("views", __dirname + "/views")

app.get "/checkout/payment", (req, res) ->
  res.render "payment"