express = require "express"
app = module.exports = express()

app.set("views", __dirname + "/views")

app.get "/products/businesscards", (req, res) ->
  res.render "businesscards"

app.post "/products/businesscards/getprice", (req, res) ->
  amount = req.body.amount
  price = getPrice +req.body.media, +amount, +req.body.numPeople

  # Save info to session
  req.session.productinfo =
    price: price
    amount: amount
    id: 20

  res.send "#{price}"

# Businesscard price "calculation" is based on the lasertryk.dk folder
getPrice = (media, amount, numPeople) ->
  console.log media, amount, numPeople
  if media is 0 and amount is 250 and numPeople is 1
    return 195
  else if media is 0 and amount is 250 and numPeople is 2
    return 285
  else if media is 0 and amount is 250 and numPeople is 3
    return 375
  else if media is 0 and amount is 250 and numPeople is 4
    return 465
  else if media is 0 and amount is 250 and numPeople is 5
    return 555
  else if media is 0 and amount is 250 and numPeople is 10
    return 780
  else if media is 0 and amount is 500 and numPeople is 1
    return 215
  else if media is 0 and amount is 500 and numPeople is 2
    return 315
  else if media is 0 and amount is 500 and numPeople is 3
    return 415
  else if media is 0 and amount is 500 and numPeople is 4
    return 515
  else if media is 0 and amount is 500 and numPeople is 5
    return 615
  else if media is 0 and amount is 500 and numPeople is 10
    return 915
  else if media is 1 and amount is 250 and numPeople is 1
    return 345
  else if media is 1 and amount is 250 and numPeople is 2
    return 520
  else if media is 1 and amount is 250 and numPeople is 3
    return 695
  else if media is 1 and amount is 250 and numPeople is 4
    return 870
  else if media is 1 and amount is 250 and numPeople is 5
    return 1045
  else if media is 1 and amount is 250 and numPeople is 10
    return 1345
  else if media is 1 and amount is 500 and numPeople is 1
    return 395
  else if media is 1 and amount is 500 and numPeople is 2
    return 620
  else if media is 1 and amount is 500 and numPeople is 3
    return 845
  else if media is 1 and amount is 500 and numPeople is 4
    return 1070
  else if media is 1 and amount is 500 and numPeople is 5
    return 1295
  else if media is 1 and amount is 500 and numPeople is 10
    return 2395
  else if media is 2 and amount is 250 and numPeople is 1
    return 545
  else if media is 2 and amount is 250 and numPeople is 2
    return 870
  else if media is 2 and amount is 250 and numPeople is 3
    return 1195
  else if media is 2 and amount is 250 and numPeople is 4
    return 1520
  else if media is 2 and amount is 250 and numPeople is 5
    return 1845
  else if media is 2 and amount is 250 and numPeople is 10
    return 2395
  else if media is 2 and amount is 500 and numPeople is 1
    return 695
  else if media is 2 and amount is 500 and numPeople is 2
    return 1140
  else if media is 2 and amount is 500 and numPeople is 3
    return 1585
  else if media is 2 and amount is 500 and numPeople is 4
    return 2030
  else if media is 2 and amount is 500 and numPeople is 5
    return 2475
  else if media is 2 and amount is 500 and numPeople is 10
    return 3575