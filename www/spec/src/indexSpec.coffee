describe "app", ->
  describe "initialize", ->
    it "should set form post url", ->
      $("<div id='login'><form class='login'></form></div>").appendTo('#stage')

      app.initialize()
      expect($('form.login').attr('url')).toEqual(login_url)

    it "should bind deviceready", ->
      runs ->
        spyOn app, "onDeviceReady"
        app.initialize()
        helper.trigger window.document, "deviceready"

      waitsFor (->
        app.onDeviceReady.calls.length > 0
      ), "onDeviceReady should be called once", 500
      runs ->
        expect(app.onDeviceReady).toHaveBeenCalled()