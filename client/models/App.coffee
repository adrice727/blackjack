#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'handStatus', 'open'

    @.get('playerHand').on('blackjack', -> do blackjackCloseOut )
    @.get('dealerHand').on('blackjack', -> do blackjackCloseOut )


  blackjackCloseOut: ->
    @set 'handStatus', 'playerBlackjack' if @.get('playerHand').scores is 21 and @.get('dealerHand').scores is not 21
    @set 'handStatus', 'dealerBlackjack' if @.get('playerHand').scores is not 21 and @.get('dealerHand').scores is 21
    @set 'handStatus', 'push' if @.get('playerHand').scores is 21 and @.get('dealerHand').scores is 21

    # handTotal = @.get('dealerHand').scores
    # while handTotal < 17 
    #   do @.hit  

    # do push if @.get('playerHand') is @.get('dealerHand')

  # blackJackWin: ->
  #   @set 'handStatus', 'blackJackWin'  








