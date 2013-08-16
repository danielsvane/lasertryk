express = require "express"
ftp = require "ftp"
resumer = require("resumer") # Makes a string streamable, so it can be sent to ftp
jsontoxml = require("jsontoxml")

app = module.exports = express()

# Upload xml
app.post "/upload", (req, res) ->
  client = new ftp()
  client.on 'ready', ->
    xml = jsontoxml # Generate xml string from json
      "order":
        "ORDRENUMMER": req.body.orderNumber
        "PRIORITET": -1
        "STATUS": 14
        "FORSENDELSE_NAVN": req.body.name
        "FORSENDELSE_ADRESSE1": req.body.address1
        "FORSENDELSE_ADRESSE2": req.body.address2
        "FORSENDELSE_POSTBY": req.body.postal + " " + req.body.city
        "BESKRIVELSE_EKSTERN": "Product info"
        "EJER": 11
        "LXBENUMMER": 8660455
        "SiteID": 1
        "DATASET": "DAT"
        "BILL_NUM_1": "0"
        "BILL_NUM_2": "0"
        "BILL_NUM_3": "0"
        "BILL_NUM_4": "0"
        "BILL_NUM_5": "0"
        "BILL_PRICE_1": "0"
        "BILL_PRICE_2": "0"
        "BILL_PRICE_3": "0"
        "BILL_PRICE_4": "0"
        "BILL_PRICE_5": "0"

    stream = resumer().queue(xml).end() # Generate stream from xml text
    client.put stream, "OrdreFTP/#{req.body.orderNumber}.xml", (err) ->
      console.log "Upload complete"
      client.end()

  client.connect
    host: "ordreftp.lasertryk.dk"
    user: "kildahl"
    password: "kildahl"

  res.send("Uploaded")