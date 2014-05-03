// Generated by CoffeeScript 1.7.1
var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

window.App = (function(_super) {
  __extends(App, _super);

  function App() {
    this.blackjackCloseOut = __bind(this.blackjackCloseOut, this);
    this.checkForBlackjack = __bind(this.checkForBlackjack, this);
    return App.__super__.constructor.apply(this, arguments);
  }

  App.prototype.initialize = function() {
    var deck;
    this.set('deck', deck = new Deck());
    this.set('playerHand', deck.dealPlayer());
    this.set('dealerHand', deck.dealDealer());
    this.set('handStatus', 'open');
    return this.get('deck').on('dealPlayer', setTimeout(this.checkForBlackjack, 1500));
  };

  App.prototype.checkForBlackjack = function() {
    if (this.get('playerHand').scores() > 10) {
      return setTimeout(this.blackjackCloseOut, 1500);
    }
  };

  App.prototype.blackjackCloseOut = function() {
    if (this.get('playerHand').scores() > 20 && this.get('dealerHand').scores() < 21) {
      this.set('handStatus', 'playerBlackjack');
    }
    if (this.get('playerHand').scores() < 21 && this.get('dealerHand').scores() > 20) {
      this.set('handStatus', 'dealerBlackjack');
    }
    if (this.get('playerHand').scores() > 20 && this.get('dealerHand').scores() > 20) {
      return this.set('handStatus', 'push');
    }
  };

  return App;

})(Backbone.Model);
