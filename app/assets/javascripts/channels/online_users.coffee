jQuery(document).on 'turbolinks:load', ->
  App.online_users = App.cable.subscriptions.create "OnlineUsersChannel",
    connected: ->
      console.log("connected to online channel")
      # Called when the subscription is ready for use on the server
    disconnected: ->
      console.log("diconnected to online channel")
      # Called when the subscription has been terminated by the server

    received: (data) ->
      console.log(data)
      users = data['users'].map (nickname) -> "<span>#{nickname}</span>"
      $('#online').html(users.join(", "))
