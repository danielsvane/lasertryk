express = require "express"
app = module.exports = express()

app.set("views", __dirname + "/views")

app.get "/products", (req, res) ->
  res.render "products"