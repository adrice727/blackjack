class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @isDealer) -> 

  hit: =>
    @add(@deck.pop()).last()
    @trigger 'hit'
    
  stand: =>
    @trigger 'stand' 

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
    if hasAce and (score + 10 <= 21) then [score + 10] else [score]  
    #added (score + 10 <= 21) to if statement to default to lower score if Ace = 11 causes bust
    #changed the order of the array from [score, score + 10]
