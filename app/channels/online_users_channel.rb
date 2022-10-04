class OnlineUsersChannel < ApplicationCable::Channel
  def subscribed
    @list_name = 'current_users_nicknames'

    stream_from 'online_users_channel'

    $redis.rpush(@list_name, nickname)
    appear
  end

  def unsubscribed
    $redis.lrem(@list_name, 1, nickname)
    appear
  end

  def appear
    @users = nicknames_list
    broadcast
  end

  private

  def nicknames_list
    $redis.lrange(@list_name, 0, -1)
  end

  def broadcast
    ActionCable.server.broadcast('online_users_channel', {users: @users.uniq})
  end

  def nickname
    current_user.nickname
  end



  #def subscribed
  #  stream_from 'online_users_channel'
  #  current_user.update(online: true)
  #  broadcast  
  #end

  #def unsubscribed
  #  current_user.update(online: false)
  #  broadcast
  #end

  #def broadcast
  #  ActionCable.server.broadcast 'online_users_channel',
  #                               user: current_user.as_json
  #end
end
