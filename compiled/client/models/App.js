// Generated by CoffeeScript 1.7.1
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  window.App = (function(_super) {
    __extends(App, _super);

    function App() {
      this.playerStands = __bind(this.playerStands, this);
      this.checkForBust = __bind(this.checkForBust, this);
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
      this.get('deck').on('dealPlayer', setTimeout(this.checkForBlackjack, 1000));
      this.get('playerHand').on('stand', (function(_this) {
        return function() {
          return _this.playerStands();
        };
      })(this));
      this.get('playerHand').on('hit', (function(_this) {
        return function() {
          return _this.checkForBust();
        };
      })(this));
      return this.get('dealerHand').on('hit', (function(_this) {
        return function() {
          return _this.checkForBust();
        };
      })(this));
    };

    App.prototype.checkForBlackjack = function() {
      if (this.get('playerHand').scores()[0] === 21 && this.get('playerHand').length === 2) {
        return setTimeout(this.blackjackCloseOut, 500);
      }
    };

    App.prototype.blackjackCloseOut = function() {
      if (this.get('playerHand').scores()[0] === 21) {
        return this.set('handStatus', 'playerBlackjack');
      }
    };

    App.prototype.checkForBust = function() {
      var dealerHandLength, dealerScore, playerScore;
      playerScore = this.get('playerHand').scores()[0];
      dealerScore = this.get('dealerHand').scores()[0];
      dealerHandLength = this.get('dealerHand').length;
      if (playerScore > 21) {
        this.set('handStatus', 'playerBust');
        return;
      }
      if (dealerScore > 21) {
        this.set('handStatus', 'dealerBust');
        return;
      }
      if (dealerScore === 21 && dealerHandLength === 2 && playerScore === !21) {
        this.set('handStatus', 'dealerBlackjack');
        return;
      }
      if (dealerScore > playerScore) {
        this.set('handStatus', 'dealerWin');
        return;
      }
      if (dealerScore >= 17 && dealerScore < playerScore) {
        this.set('handStatus', 'playerWin');
        return;
      }
      if (dealerScore === playerScore) {
        this.set('handStatus', 'push');
      }
    };

    App.prototype.playerStands = function() {
      var dealerCloseOut, dealerHandLength, dealerScore, playerScore;
      playerScore = this.get('playerHand').scores()[0];
      dealerScore = this.get('dealerHand').scores()[0];
      dealerHandLength = this.get('dealerHand').length;
      setTimeout(((function(_this) {
        return function() {
          return _this.get('dealerHand').models[0].flip();
        };
      })(this)), 500);
      this.checkForBust;
      dealerCloseOut = (function(_this) {
        return function() {
          _this.get('dealerHand').hit();
          if (!(_this.get('handStatus') === 'open' || _this.get('dealerHand').scores()[0] < 17)) {
            return;
          }
          return setTimeout(dealerCloseOut, 500);
        };
      })(this);
      return setTimeout(dealerCloseOut, 500);
    };

    return App;

  })(Backbone.Model);

}).call(this);

//# sourceMappingURL=App.map
