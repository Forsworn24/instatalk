jQuery(document).on 'turbolinks:load', ->
  App.online_users = App.cable.subscriptions.create "OnlineUsersChannel",
    connected: ->
      # Called when the subscription is ready for use on the server
    disconnected: ->
      # Called when the subscription has been terminated by the server

    received: (data) ->
      # Called when there's incoming data on the websocket for this channel
      console.log('Received message: ' + data['user'].nickname);
      if data['user'].online && $("span[data-user-id='#{data['user'].id}'").length == 0
        $('#online').append("<span data-user-id='#{data['user'].id}'>#{data['user'].nickname} </span>")
      else if !data['user'].online
        $("span[data-user-id='#{data['user'].id}'").remove()

    speak: ->
      @perform 'speak'
