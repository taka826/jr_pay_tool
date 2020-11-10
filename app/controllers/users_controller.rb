class UsersController < ApplicationController
  def show
    @nickname = current_user.nickname
    @railways = current_user.railways
  end
end
