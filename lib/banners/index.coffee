express = require "express"
app = module.exports = express()

app.set("views", __dirname)

# Render product banners
app.get "/", (req, res) ->
  res.render "banners"