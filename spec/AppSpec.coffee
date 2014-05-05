assert = chai.assert

describe 'deck', ->
  deck = null
  playerhand = null
  dealerHand = null

  beforeEach ->
    deck = new Deck()
    @set 'handStatus', 'open'


  describe 'Player Blackjack', ->

    it 'should determine when the player has a blackjack', ->

      dealerHand = deck.dealDealer()
      playerHand = new Hand [10,11]
      assert.strictEqual playerHand.scores[0], 21
      assert('handStatus' is 'playerBlackjack')

  describe 'Player Bust', ->  

    it 'should determine when the player busts', ->

      dealerHand = deck.dealDealer()
      playerHand = new Hand [10,10]
      playerHand.hit()
      playerHand.hit()
      assert('handStatus' is 'playerBust')    

  describe 'Dealer Bust', ->  

    it 'should determine when the dealer busts', ->

      dealerHand = new Hand [10,10]
      playerHand = deck.dealPlayer()
      dealerHand.hit()
      dealerHand.hit()
      assert('handStatus' is 'dealerBust')  

  describe 'Player Win', ->

    it 'should determine when the player wins', ->

      playerHand = [10,10]
      dealerHand = [10,9]
      playerHand.stand()
      assert('handStatus' is 'playerWin')

  describe 'Dealer Win', ->

    it 'should determine when the dealer wins', ->

    playerHand = [10,9]
    assert.strictEqual playerHand.scores[0], 19
    dealerHand = [10,10]
    assert.strictEqual dealerHand.scores[0], 20
    playerHand.stand()
    assert('handStatus' is 'dealerWin')


  describe 'Push', ->

    it 'should determine when the dealer wins', ->

    playerHand = [10,8]
    assert.strictEqual playerHand.scores[0], 18
    dealerHand = [10,8]
    assert.strictEqual dealerHand.scores[0], 18
    playerHand.stand()
    assert('handStatus' is 'push')    

