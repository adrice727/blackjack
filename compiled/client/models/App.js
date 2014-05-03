// Generated by CoffeeScript 1.7.1
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  window.App = (function(_super) {
    __extends(App, _super);

    function App() {
      return App.__super__.constructor.apply(this, arguments);
    }

    App.prototype.initialize = function() {
      var deck;
      this.set('deck', deck = new Deck());
      this.set('playerHand', deck.dealPlayer());
      this.set('dealerHand', deck.dealDealer());
      this.set('handStatus', 'open');
      this.get('playerHand').on('blackjack', function() {
        return blackjackCloseOut();
      });
      return this.get('dealerHand').on('blackjack', function() {
        return blackjackCloseOut();
      });
    };

    App.prototype.blackjackCloseOut = function() {
      alert("blackjack things . . .");
      if (this.get('playerHand').scores === 21 && this.get('dealerHand').scores === !21) {
        this.set('handStatus', 'playerBlackjack');
      }
      if (this.get('playerHand').scores === !21 && this.get('dealerHand').scores === 21) {
        this.set('handStatus', 'dealerBlackjack');
      }
      if (this.get('playerHand').scores === 21 && this.get('dealerHand').scores === 21) {
        return this.set('handStatus', 'push');
      }
    };

    return App;

  })(Backbone.Model);

}).call(this);

//# sourceMappingURL=App.map
