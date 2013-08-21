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

app.get "/order/deliveryinfo", (req, res) ->
  res.render "deliveryinfo"

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

app.post "/savedeliveryinfo", (req, res) ->
  req.session.deliveryinfo = req.body

  # Get order number from lasertryk
  http.get "http://www.lasertryk.dk/api/getordernumber.aspx" , (response) ->

    console.log "hej"
    response.setEncoding "utf8"
    response.on "data", (orderNumber) ->

      console.log "hejhej"
      file = req.session.file
      deliveryinfo = req.session.deliveryinfo
      productinfo = req.session.productinfo

      # Generate xml from session data
      xml = jsontoxml
        "Order":
          "OrderNumber": orderNumber
          "Priority": -1
          "Status": 14
          "DeliveryName": deliveryinfo.name
          "DeliveryAddress1": deliveryinfo.address1
          "DeliveryAddress2": deliveryinfo.address2
          "DeliveryPostalCity": deliveryinfo.postal + " " + deliveryinfo.city
          "DescriptionExtern": "Product info"
          "Owner": 11
          "SiteId": 1
          "DataSet": "DAT"
          "ReferenceNumber": 8660455
          "FileName": file.name
          "DeliveryPhone": deliveryinfo.phone
          "DeliveryEmail": deliveryinfo.email
          "BillAccount1": 11504
          "BillAmount1": productinfo.amount
          "BillText1": "Printmetode "+productinfo.printMethod
          "BillPrice1": productinfo.price


      client = new ftp()

      client.on "ready", ->
        console.log "hejhejhek"
        # Step into upload folder
        client.cwd "OrdreFTP", (err) ->
          # Upload print file to ftp
          client.put file.path, file.name, (err) ->
            console.log err
            # Upload xml file to ftp
            stream = resumer().queue(xml).end() # Generate stream from xml text
            client.put stream, orderNumber+".xml", (err) ->
              res.send orderNumber
              client.end()
            # Remove the uploaded file from temp storage
            fs.unlink file.path, (err) ->
              console.log err
              console.log "Temporary file removed"

      client.connect
        host: "ordreftp.lasertryk.dk"
        user: "kildahl"
        password: "kildahl"


