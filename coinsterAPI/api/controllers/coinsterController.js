'use strict';

var request = require('request');

exports.list_all_coins = function(req, res) {
  console.log('all coins');

  request('https://api.coinmarketcap.com/v1/ticker/?limit=0', function (error, response, body) {
    console.log('error:', error); // Print the error if one occurred and handle it
    console.log('statusCode:', response && response.statusCode); // Print the response status code if a response was received
    res.send(body);
  });
};

exports.list_coins = function(req, res) {
  console.log('here');
};
