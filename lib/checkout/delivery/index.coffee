express = require "express"
app = module.exports = express()

app.set("views", __dirname + "/views")

app.get "/checkout/delivery", (req, res) ->
  res.render "delivery"

app.post "/checkout/delivery/save", (req, res) ->
  req.session.delivery = req.body
  res.send "Saved delivery info"