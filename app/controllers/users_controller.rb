class UsersController < ApplicationController
  def home; end

  def about; end

  def index; end

  def show
    @user = User.find(params[:id])
    @image = @user.image.url
  end

  def edit
    user = User.find(params[:id])
    @image = user.image
  end

  private

  def user_params
    params.require(:user).permit(:id, :name, :email, :image, :profile)
  end
end
