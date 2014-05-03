class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @isDealer) -> 
    # debugger
    @on('add', @checkForBlackjack() )

  checkForBlackjack: ->
    @trigger('blackjack') if @length is 2 and @scores() is 21   

  hit: ->
    @add(@deck.pop()).last()
    @trigger('bust') if @.scores > 21

  stand: ->
    @trigger('stand')

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    hasAce = @reduce (memo, card) ->
      memo or card.get('value') is 1
    , false
    score = @reduce (score, card) ->
      score + if card.get 'revealed' then card.get 'value' else 0
    , 0
    if hasAce then [score + 10, score] else [score]  #changed the order of the array from [score, score + 10]
