app =
  initialize: ->
    this.bindEvents()
    new LoginView()
  bindEvents: ->
    document.addEventListener('deviceready', this.onDeviceReady, false)
  onDeviceReady: ->
    new LoginView()

LoginView = Backbone.View.extend
  el: '#login'
  events:
    'submit form.login': '_submit'

  initialize: ->
    $('form.login').attr('url', login_url)
    this._initClearButton()
    this._initSubmitButton()

  _initClearButton: ->
    $('input.deletable').wrap('<span class="deleteicon" />').after $('<span/>')

    $('input.deletable').focus ->
      $(this).next().addClass 'active'

    $('input.deletable').blur ->
      $(this).next().removeClass 'active'

    $('.deleteicon span').on 'pointerdown', ->
      $(this).addClass 'pressed'
      $(this).prev().val ''

    $('.deleteicon span').on 'pointerup', ->
      $(this).removeClass 'pressed'

  _initSubmitButton: ->
    $('input.submit').on 'tap', ->
      $(this).addClass 'pressed'

  _submit: ->
    event.preventDefault()
    $.ajax
      type: 'POST'
      url: login_url
      data: $('form.login').serialize()
      dataType: 'json'
      beforeSend: (xhr, settings) ->
        $("#login").animate {opacity: 0}, 200, 'ease-out', ->
          $('#loading').show()
      success: (data, status, xhr) ->
        console.log data
        $('#login').hide()
        dashboard.initialize()
      error: (xhr, errorType, error) ->
        $('#loading').hide()
        $('#login').css 'opacity', 1
        $('#login .error').text $.parseJSON(xhr.response).error

$(document).on 'click', '.logout', ->
  $.ajax
    type: 'POST'
    url: logout_url
    dataType: 'json'