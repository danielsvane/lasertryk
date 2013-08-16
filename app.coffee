# Setup
express = require("express")
http = require("http")
path = require("path")
ftp = require("ftp")
resumer = require("resumer") # Makes a string streamable, so it can be sent to ftp
jsontoxml = require("jsontoxml")
mongostore = require("connect-mongo")(express)

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
app.use express.cookieParser()
app.use express.session
  secret: "whypleasedeargod"
  store: new mongostore
    db: "lasertryk"

# Load modules
app.use require("./lib/banners")
app.use require("./lib/upload")

# Start server
http.createServer(app).listen app.get("port"), ->
  console.log "Express server listening on port " + app.get("port")