#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'handStatus', 'open'

    # check for player blackjack
    @get('deck').on 'dealPlayer', setTimeout(@checkForBlackjack, 1500)
    @get('playerHand').on 'stand', () => @playerStands()

  checkForBlackjack: =>
    console.log @get('dealerHand').scores()[0]
    if @get('playerHand').scores()[0] is 21 then setTimeout( @blackjackCloseOut , 1500)

  blackjackCloseOut: =>
    @set 'handStatus', 'playerBlackjack' if @get('playerHand').scores()[0] is 21
    # @set 'handStatus', 'dealerBlackjack' if @get('dealerHand').scores()[0] is 21 and @get('playerHand').scores()[0] is not 21
    # @set 'handStatus', 'push' if @get('playerHand').scores()[0] is 20 and @get('dealerHand').scores()[0] is 21

  playerStands: =>
    setTimeout( (() => @get('dealerHand').models[0].flip()), 500)
    # @get('dealerHand').hit()

    # dealerScoreHard = @get('dealerHand').scores()[0]
    # dealerScoreSoft = @get('dealerHand').scores()[1] 
    playerScore = @get('playerHand').scores()[0]

    @set 'handStatus', 'dealerBlackjack' if @get('dealerHand').scores()[0] is 21 and playerScore is not 21
    
    @get('dealerHand').hit() while @get('dealerHand').scores()[0] < 17 and @get('dealerHand').scores()[0] < playerScore and
      @get('dealerHand').scores()[1] < 17 and @get('dealerHand').scores()[1] < playerScore
    








