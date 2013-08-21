# Setup
express = require("express")
http = require("http")
path = require("path")
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
app.use require('connect-assets')
  src: __dirname
app.use express.static(path.join(__dirname, "public"))
app.use express.errorHandler() if "development" is app.get("env")
app.use express.cookieParser()
app.use express.session
  secret: "whypleasedeargod"
  store: new mongostore
    url: "mongodb://daniel:c0ff33m4st3r@ds037468.mongolab.com:37468/heroku_app17067005/sessions"
  , ->  
    # Start server when mongo is connected
    http.createServer(app).listen app.get("port"), ->
      console.log "Express server listening on port " + app.get("port")

# Load modules
app.use require("./lib/products")
app.use require("./lib/products/businesscards")
app.use require("./lib/banners")
app.use require("./lib/checkout/delivery")
app.use require("./lib/checkout/payment")