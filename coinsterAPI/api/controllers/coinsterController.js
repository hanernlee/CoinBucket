'use strict';

var request = require('request');
var Coin = require("../models/coin")

exports.list_all_coins = function(req, res) {
  const currency = req.query.currency;
  const currencyLower = currency.toLowerCase();

  request('https://api.coinmarketcap.com/v1/ticker/?convert=${currency}&limit=0', function (error, response, body) {
    if (error) {
      res.send(error);
    }

    if (response && response.statusCode && response.statusCode == 200) {
      const data = JSON.parse(body);

      var coins = [];

      for(var i = 0; i < data.length; i ++) {
        var coin = new Coin(data[i]);
        coin.price = data[i]["price_" + currencyLower];
        coin.market_cap = data[i]["market_cap_" + currencyLower];
        coins.push(coin);
      } 

      res.send(coins);
    } else {
      res.send("API Error");
    }
  });
};

exports.list_coins = function(req, res) {
  const currency = req.query.currency;
  const currencyLower = currency.toLowerCase();
  const start = req.query.start;

  request(`https://api.coinmarketcap.com/v1/ticker/?convert=${currency}&start=${start}&limit=500"`, function (error, response, body) {
    if (error) {
      res.send(error);
    }

    if (response && response.statusCode && response.statusCode == 200) {
      const data = JSON.parse(body);

      var coins = [];

      for(var i = 0; i < data.length; i ++) {
        var coin = new Coin(data[i]);
        coin.price = data[i]["price_" + currencyLower];
        coin.market_cap = data[i]["market_cap_" + currencyLower];
        coins.push(coin);
      } 

      res.send(coins);
    } else {
      res.send("API Error");
    }
  });
};

exports.list_coin = function(req, res) {
  const id = req.params.id;
  const currency = req.query.currency;
  const currencyLower = currency.toLowerCase();

  request(`https://api.coinmarketcap.com/v1/ticker/${id}/?convert=${currency}&"`, function (error, response, body) {
    if (error) {
      res.send(error);
    }

    if (response && response.statusCode && response.statusCode == 200) {
      const data = JSON.parse(body);

      var coins = [];

      for(var i = 0; i < data.length; i ++) {
        var coin = new Coin(data[i]);
        coin.price = data[i]["price_" + currencyLower];
        coin.market_cap = data[i]["market_cap_" + currencyLower];
        coins.push(coin);
      } 

      res.send(coins);
    } else {
      res.send("API Error");
    }
  });
};