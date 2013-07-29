# Setup
express = require("express")
http = require("http")
path = require("path")
app = express()
app.set "port", process.env.PORT or 3000
app.set "views", __dirname + "/views"
app.set "view engine", "jade"
app.use express.favicon()
app.use express.logger("dev")
app.use express.bodyParser()
app.use express.methodOverride()
app.use app.router
app.use require("stylus").middleware(__dirname + "/public")
app.use require('connect-assets')()
app.use express.static(path.join(__dirname, "public"))
app.use express.errorHandler()  if "development" is app.get("env")

# Routes
app.get "/", (req, res) ->
  res.render "banners"

# Start server
http.createServer(app).listen app.get("port"), ->
  console.log "Express server listening on port " + app.get("port")