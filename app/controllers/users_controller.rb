class UsersController < ApplicationController
  def home; end

  def about; end

  def index
    @users = User.page(params[:page]).order(id: "ASC").per(15)
  end

  def show
    @user = User.find(params[:id])
    @image = @user.image.url
  end

  def following
    @title = 'フォロー中'
    @user = User.find(params[:id])
    @users = @user.following.page(params[:page]).per(15)
    render 'show_follow'
  end

  def followers
    @title = 'フォロワー'
    @user = User.find(params[:id])
    @users = @user.followers.page(params[:page]).per(15)
    render 'show_follow'
  end

  private

  def user_params
    params.require(:user).permit(:id, :name, :email, :image, :profile)
  end
end
