/** coin.js **/

var Coin = function (data) {
  this.id = data.id;
  this.name = data.name;
  this.symbol = data.symbol;
  this.price_btc = data.price_btc;
  this.price_usd = data.price_usd;
  this.market_cap_usd = data.market_cap_usd;
  this.last_updated = data.last_updated;
  this.total_supply = data.total_supply;
  this.percent_change_1h = data.percent_change_1h;
  this.percent_change_24h = data.percent_change_24h;
  this.percent_change_7d = data.percent_change_7d;
}

Coin.prototype.data = {}

module.exports = Coin;