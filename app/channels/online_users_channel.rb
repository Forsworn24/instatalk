class OnlineUsersChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'online_users_channel'
    current_user.update(online: true)
    broadcast  
  end

  def unsubscribed
    current_user.update(online: false)
    broadcast
  end

  def broadcast
    ActionCable.server.broadcast 'online_users_channel',
                                 user: current_user.as_json
  end
end
