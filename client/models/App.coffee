#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'handStatus', 'open'

    # check for player blackjack
    @get('deck').on 'dealPlayer', setTimeout(@checkForBlackjack, 1000)
    @get('playerHand').on 'stand', () => @playerStands()
    @get('playerHand').on 'hit', () => @checkForBust()
    @get('dealerHand').on 'hit', () => @checkForBust()


  checkForBlackjack: =>
    if @get('playerHand').scores()[0] is 21 and @get('playerHand').length is 2 then setTimeout( @blackjackCloseOut , 500)

  blackjackCloseOut: =>
    @set 'handStatus', 'playerBlackjack' if @get('playerHand').scores()[0] is 21 
  
  checkForBust: =>
    playerScore = @get('playerHand').scores()[0]
    dealerScore = @get('dealerHand').scores()[0]
    dealerHandLength = @get('dealerHand').length
    if playerScore > 21
      @set 'handStatus', 'playerBust'
      return
    if dealerScore > 21
      @set 'handStatus', 'dealerBust'
      return
    if dealerScore is 21 and dealerHandLength is 2 and playerScore is not 21
      @set 'handStatus', 'dealerBlackjack'
      return
    if dealerScore > playerScore
      @set 'handStatus', 'dealerWin'
      return
    if dealerScore is playerScore  
      @set 'handStatus', 'push'
      
    # @set 'handStatus', 'playerBust' if playerScore > 21
    # @set 'handStatus', 'dealerBust' if dealerScore > 21
    # @set 'handStatus', 'dealerBlackjack' if dealerScore is 21 and dealerHandLength is 2 and playerScore is not 21
    # @set 'handStatus', 'dealerWin' if dealerScore > playerScore
    # @set 'handStatus', 'push' if dealerScore is playerScore

    # switch @set('handStatus')
    #   when playerScore > 21 then 'playerBust'
    #   when dealerScore > 21 then'dealerBust'
    #   when dealerScore is 21 and dealerHandLength is 2 and playerScore is not 21 then 'dealerBlackjack'
    #   when dealerScore > playerScore then 'dealerWin'
    #   when dealerScore is playerScore then 'push'

  playerStands: =>
    
    playerScore = @get('playerHand').scores()[0]
    dealerScore = @get('dealerHand').scores()[0]
    dealerHandLength = @get('dealerHand').length

    setTimeout( (() => 
      @get('dealerHand').models[0].flip()), 500)

    @checkForBust

    dealerCloseOut = () =>
      @get('dealerHand').hit()
      return unless @get('handStatus') is 'open' or @get('dealerHand').scores()[0] < 17
      setTimeout dealerCloseOut, 500
    
    setTimeout dealerCloseOut, 500 






    








