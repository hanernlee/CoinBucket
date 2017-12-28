'use strict';

var request = require('request');
var Coin = require("../models/coin")

exports.list_all_coins = function(req, res) {
  request('https://api.coinmarketcap.com/v1/ticker/?limit=0', function (error, response, body) {
    console.log('error:', error); // Print the error if one occurred and handle it
    console.log('statusCode:', response && response.statusCode); // Print the response status code if a response was received

    const bodyRes = JSON.parse(body);
    console.log(bodyRes[0].id);

    res.send(bodyRes);

  });
};

exports.list_coins = function(req, res) {
  console.log(req.params);

  const convertCurrency = "USD";
  const start = 0

  request(`https://api.coinmarketcap.com/v1/ticker/?convert=${convertCurrency}&start=${start}&limit=500`, function (error, response, body) {
    console.log('error:', error); // Print the error if one occurred and handle it
    console.log('statusCode:', response && response.statusCode); // Print the response status code if a response was received

    const bodyRes = JSON.parse(body);
    console.log(bodyRes[0].id);

    res.send(bodyRes);

  });
};
