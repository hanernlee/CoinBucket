'use strict';
module.exports = function(app) {
  var coinList = require('../controllers/coinsterController');

  // coinList Routes
  app.route('/')
    .get(coinList.list_all_coins);

  app.route('/coins')
    .get(coinList.list_coins);

  app.route('/coin/:id')
    .get(coinList.list_coin);
};