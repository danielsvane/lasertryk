express = require "express"
app = module.exports = express()
ftp = require "ftp"
fs = require "fs"
http = require "http"
jsontoxml = require("jsontoxml")
resumer = require("resumer") # Makes a string streamable, so it can be sent to ftp

app.set("views", __dirname)

app.get "/", (req, res) ->
  res.redirect "/products/banners/"

# Render product banners
app.get "/products/banners", (req, res) ->
  req.param.title
  res.render "banners"

app.get "/products/:product/upload", (req, res) ->
  res.render "upload"

app.get "/order/customerinfo", (req, res) ->
  res.render "customerinfo"

app.post "/saveproductinfo", (req, res) ->
  req.session.productinfo = req.body
  res.send "ok"

app.post "/uploadprint", (req, res) ->
  file = req.files.files[0]
  # Save file info to session
  req.session.file =
    path: file.path
    name: file.name
  # Send correct response to file upload plugin
  res.send
    "files": [
      {
        "name": file.name
      }
    ]

app.post "/savecustomerinfo", (req, res) ->
  req.session.customerinfo = req.body

  # Get order number from lasertryk
  http.get "http://www.lasertryk.dk/api/getordernumber.aspx" , (resonse) ->
    resonse.setEncoding "utf8"
    resonse.on "data", (orderNumber) ->

      # Generate xml from session data
      xml = jsontoxml
        "order":
          "ORDRENUMMER": orderNumber
          "PRIORITET": -1
          "STATUS": 14
          "FORSENDELSE_NAVN": req.session.customerinfo.name
          "FORSENDELSE_ADRESSE1": req.session.customerinfo.address1
          "FORSENDELSE_ADRESSE2": req.session.customerinfo.address2
          "FORSENDELSE_POSTBY": req.session.customerinfo.postal + " " + req.session.customerinfo.city
          "BESKRIVELSE_EKSTERN": "Product info"
          "EJER": 11
          "LXBENUMMER": 8660455
          "SiteID": 1
          "DATASET": "DAT"
          
      client = new ftp()

      client.on "ready", ->
        # Step into upload folder
        client.cwd "OrdreFTP/test", (err) ->
          # Create print folder
          client.mkdir orderNumber, (err) ->
            console.log err
            # Upload print file to ftp
            client.put req.session.file.path, orderNumber+"/"+req.session.file.name, (err) ->
              console.log err
              # Upload xml file to ftp
              stream = resumer().queue(xml).end() # Generate stream from xml text
              client.put stream, orderNumber+".xml", (err) ->
                res.send orderNumber
                client.end()
              # Remove the uploaded file from temp storage
              fs.unlink req.session.file.path, (err) ->
                console.log err
                console.log "Temporary file removed"

      client.connect
        host: "DMZSVC10"
        user: "kildahl"
        password: "kildahl"


