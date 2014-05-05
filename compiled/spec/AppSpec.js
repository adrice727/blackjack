// Generated by CoffeeScript 1.7.1
(function() {
  var assert;

  assert = chai.assert;

  describe('deck', function() {
    var dealerHand, deck, playerhand;
    deck = null;
    playerhand = null;
    dealerHand = null;
    beforeEach(function() {
      deck = new Deck();
      return this.set('handStatus', 'open');
    });
    describe('Player Blackjack', function() {
      return it('should determine when the player has a blackjack', function() {
        var playerHand;
        dealerHand = deck.dealDealer();
        playerHand = new Hand([10, 11]);
        assert.strictEqual(playerHand.scores[0], 21);
        return assert('handStatus' === 'playerBlackjack');
      });
    });
    describe('Player Bust', function() {
      return it('should determine when the player busts', function() {
        var playerHand;
        dealerHand = deck.dealDealer();
        playerHand = new Hand([10, 10]);
        playerHand.hit();
        playerHand.hit();
        return assert('handStatus' === 'playerBust');
      });
    });
    describe('Dealer Bust', function() {
      return it('should determine when the dealer busts', function() {
        var playerHand;
        dealerHand = new Hand([10, 10]);
        playerHand = deck.dealPlayer();
        dealerHand.hit();
        dealerHand.hit();
        return assert('handStatus' === 'dealerBust');
      });
    });
    describe('Player Win', function() {
      return it('should determine when the player wins', function() {
        var playerHand;
        playerHand = [10, 10];
        dealerHand = [10, 9];
        playerHand.stand();
        return assert('handStatus' === 'playerWin');
      });
    });
    describe('Dealer Win', function() {
      var playerHand;
      it('should determine when the dealer wins', function() {});
      playerHand = [10, 9];
      assert.strictEqual(playerHand.scores[0], 19);
      dealerHand = [10, 10];
      assert.strictEqual(dealerHand.scores[0], 20);
      playerHand.stand();
      return assert('handStatus' === 'dealerWin');
    });
    return describe('Push', function() {
      var playerHand;
      it('should determine when the dealer wins', function() {});
      playerHand = [10, 8];
      assert.strictEqual(playerHand.scores[0], 18);
      dealerHand = [10, 8];
      assert.strictEqual(dealerHand.scores[0], 18);
      playerHand.stand();
      return assert('handStatus' === 'push');
    });
  });

}).call(this);

//# sourceMappingURL=AppSpec.map
