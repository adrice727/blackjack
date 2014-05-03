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

  #not sure why I need to use double arrow as opposed to single arrow here
  checkForHandOver: =>
    @displayResult() if @model.get('handStatus')

  #Player Blackjack win is working.
  displayResult: =>
    alert "Blackjack!!! You win!!!" if @model.get('handStatus') is 'playerBlackjack'
    alert "Dealer Blackjack.  You lost.  You're a loser" if @model.get('handStatus') is 'dealerBlackjack'

