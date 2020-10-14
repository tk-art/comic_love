class UsersController < ApplicationController
  def home
    @categories = Category.page(params[:page])
    @posts = Post.includes(:user).page(params[:page]).order(created_at: 'DESC').per(10)
    @post_feeds = current_user.feed.includes(:user).page(params[:page]).order(created_at: 'DESC').per(10) if user_signed_in?
  end

  def about; end

  def search
    @user_or_post = params[:option]
    if @user_or_post == '1'
      @users = User.search(params[:search], @user_or_post)
                   .page(params[:page]).per(10)
    else
      @posts = Post.includes(:user).search(params[:search], @user_or_post)
                   .page(params[:page]).per(10)
    end
  end

  def index
    @users = User.includes(:image_attachment).page(params[:page]).order(id: 'DESC').per(15)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).order(created_at: 'DESC').per(10)
    @image = @user.image
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
