class CategoriesController < ApplicationController
  def show
    @categories = Category.page(params[:page])
    @categories_show = @categories.find(params[:id])
    @category = @categories_show.posts.includes(:user).order(created_at: 'DESC')
  end
end
