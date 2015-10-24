class window.Hand extends Backbone.Collection
  model: Card

  initialize: (@array, @deck, @isDealer) ->

  hit: ->
    @add(@deck.pop())
    person = if @isDealer then 'Dealer' else 'Player' 

    score = @scores()
    console.log(score)

    max = Math.max(score[0], score[1])
    min = Math.min(score[0], score[1])
    console.log("Max", max)
    console.log("Max", min)

    if max > 21
      max = min


    if max > 21 
      alert(person + 'loses') 
    else if (score is 21)
      alert(person + 'wins')

    @last()
 
  stand: ->
    @array[0].flip()
    @hit(true) while @minScore() < 17 
    @trigger('standEvent')

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]


