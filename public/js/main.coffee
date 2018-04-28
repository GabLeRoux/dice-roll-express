loadFont = ->
  WebFontConfig =
    active: ->
      console.log 'Font loaded'
      return

    custom:
      families: ['BebasNeue']
      urls: ['/components/font-bebas-neue/font-bebas-neue.css']

  WebFont.load WebFontConfig
  console.log 'called webfont loading', WebFontConfig

roll = ->
  expression = encodeURIComponent $("#search").val()
  console.log("roll " + expression)
  $.get
    url: "/dice/" + expression
    data: {}
    success: (response) ->
      console.log response
      $("#result").text response.value

registerEnter = ->
  $("#search").keyup (event) ->
    if event.keyCode == 13
      console.log("Enter like a hacker!")
      $("#roll").click()

$(document).ready ->
  loadFont()
  registerEnter()
  console.log("Let's roll!")
  $("#roll").click (e) ->
    e.preventDefault()
    roll()
