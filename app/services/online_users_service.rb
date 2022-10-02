class OnlineUsersService
  def initialize(users)
    @users = users
  end

  def perform
    broadcast_online
  end

  private

  def broadcast_online
    ActionCable.server.broadcast 'online_users_channel',
                                 user: @users
  end

  def render_users_online
    ApplicationController.renderer.render(partial: 'layouts/online_users', locals: {
      users_online: @users_online
    })
  end
end
