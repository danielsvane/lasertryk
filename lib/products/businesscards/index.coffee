express = require "express"
app = module.exports = express()

app.set("views", __dirname + "/views")

app.get "/products/businesscards", (req, res) ->
  res.render "businesscards"

app.post "/products/businesscards/getprice", (req, res) ->
  amount = req.body.amount
  price = amount/250
  console.log price
  res.send "#{price}"