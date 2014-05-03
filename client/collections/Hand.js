// Generated by CoffeeScript 1.7.1
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

window.Hand = (function(_super) {
  __extends(Hand, _super);

  function Hand() {
    return Hand.__super__.constructor.apply(this, arguments);
  }

  Hand.prototype.model = Card;

  Hand.prototype.initialize = function(array, deck, isDealer) {
    this.deck = deck;
    this.isDealer = isDealer;
    return this.on('add', this.checkForBlackjack());
  };

  Hand.prototype.checkForBlackjack = function() {
    if (this.length === 2 && this.scores() === 21) {
      return this.trigger('blackjack');
    }
  };

  Hand.prototype.hit = function() {
    this.add(this.deck.pop()).last();
    if (this.scores > 21) {
      return this.trigger('bust');
    }
  };

  Hand.prototype.stand = function() {
    return this.trigger('stand');
  };

  Hand.prototype.scores = function() {
    var hasAce, score;
    hasAce = this.reduce(function(memo, card) {
      return memo || card.get('value') === 1;
    }, false);
    score = this.reduce(function(score, card) {
      return score + (card.get('revealed') ? card.get('value') : 0);
    }, 0);
    if (hasAce) {
      return [score + 10, score];
    } else {
      return [score];
    }
  };

  return Hand;

})(Backbone.Collection);
