#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'handStatus', 'open'

    # check for player blackjack
    @get('deck').on 'dealPlayer', setTimeout(@checkForBlackjack, 1500)

  checkForBlackjack: =>
    # Using > 20 because neither 'is' or '==' are working.  Do not know why.
    if @get('playerHand').scores() > 10 then setTimeout(@blackjackCloseOut, 1500)

  blackjackCloseOut: =>
    @set 'handStatus', 'playerBlackjack' if @get('playerHand').scores() > 20 and @get('dealerHand').scores() < 21
    @set 'handStatus', 'dealerBlackjack' if @get('playerHand').scores() < 21 and @get('dealerHand').scores() > 20
    @set 'handStatus', 'push' if @get('playerHand').scores() > 20 and @get('dealerHand').scores() > 20










