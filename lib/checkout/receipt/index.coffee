express = require "express"
app = module.exports = express()
app.set("views", __dirname + "/views")

app.get "/checkout/receipt", (req, res) ->
  res.render "receipt"