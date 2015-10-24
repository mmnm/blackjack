class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> @model.get('dealerHand').stand()

  initialize: ->
    @listenTo(@model.get('dealerHand'), 'standEvent', @computeScore)
    @render()


  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  computeScore: -> 
    playerScore = @model.get('playerHand').scores()
    dealerScore = @model.get('dealerHand').scores()

    playerScoreMin = Math.max(playerScore[0], playerScore[1])
    playerScoreMax = Math.max(playerScore[0], playerScore[1])
    
    if playerScoreMax > 21 
      playerScoreMax = playerScoreMin

    dealerScoreMin = Math.max(dealerScore[0], dealerScore[1])
    dealerScoreMax = Math.max(dealerScore[0], dealerScore[1])
    
    if playerScoreMax > 21 
      playerScoreMax = playerScoreMin

    if dealerScoreMax > 21 
      dealerScoreMax = dealerScoreMin

    if playerScoreMax > 21 and dealerScoreMax > 21 
      alert('Nobody wins or loses') 
    else if (playerScoreMax > 21)
      alert('Dealer wins')
    else if (dealerScoreMax > 21)
      alert('Player wins')
    else if(playerScoreMax > dealerScoreMax)
      alert('Player wins')


