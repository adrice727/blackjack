class window.AppView extends Backbone.View

  template: _.template '
    <button class="hit-button pure-button button-secondary">Hit</button> <button class="stand-button pure-button button-error">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    "click .hit-button": -> @model.get('playerHand').hit()
    "click .stand-button": -> @model.get('playerHand').stand()


  initialize: ->
    @render()
    # Need a way to update the view when the hand is over but this updates on every change
    # including initialization
    @model.on 'change:handStatus', @checkForHandOver

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  checkForHandOver: =>
    console.log 'getting HERE'
    console.log @model.get('handStatus')
    @displayResult()

  displayResult: =>
    console.log 'here and there' , @model.get('handStatus')
    alert 'Blackjack!!! You win!!!' if @model.get('handStatus') is 'playerBlackjack'
    alert 'Dealer Blackjack. You lost' if @model.get('handStatus') is 'dealerBlackjack'
    alert 'Bust. You went over 21.' if @model.get('handStatus') is 'playerBust'
    alert 'Dealer busts. You win!!!' if @model.get('handStatus') is 'dealerBust'
    alert 'Dealer wins.' if @model.get('handStatus') is 'dealerWin'
    alert 'Push. Player and dealer have same score' if @model.get('handStatus') is 'push'

