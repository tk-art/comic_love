class UsersController < ApplicationController
  def home; end

  def index
    @users = User.all
  end

  def show
    @user = current_user
  end

  def about; end
end
