class PostsController < ApplicationController
  def new
    @isbn = session[:isbn]
  end

  def isbn
    if params[:isbn] && params[:isbn].length == 13
      session[:isbn] = params[:isbn]
      redirect_to new_post_url
    end
  end

  def search
    @items = []
    if params[:keyword].present?
      item = RakutenWebService::Books::Book.search({
                                                     title: params[:keyword],
                                                     hits: 20
                                                   })

      item.each do |i|
        item = current_user.posts.build(read(i))
        @items << item
      end
    else
      render 'search'
    end
  end

  def show
    @post = Post.find(params[:id])
    @categories = @post.categories
    @category = []
    @categories.each do |category|
      related_posts = category.posts.where.not(id: @post.id)
      related_posts.each do |posts|
        @category << posts
      end
    end
    @category_ary = @category.uniq.shuffle
    @comments = @post.comments.includes(:user).order(created_at: 'DESC')
    @comment = current_user.comments.build
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params1)
      flash[:notice] = '投稿の編集に成功しました！'
      redirect_to current_user
    else
      flash[:alert] = '投稿の編集に失敗しました！'
      render 'edit'
    end
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:notice] = '投稿に成功しました！'
      redirect_to user_path(current_user)
    else
      flash[:alert] = '投稿に失敗しました！'
      render 'new'
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    if @post.destroy
      flash[:notice] = '削除が成功しました！'
    else
      flash[:alert] = '削除に失敗しました！'
    end
    redirect_to user_path(current_user)
  end

  private

  def post_params
    params.permit(:user_id, :content, :isbn, :title, :url, :image_url, category_ids: [])
  end

  def post_params1
    params.require(:post).permit(:user_id, :content, :isbn, :title, :url, :image_url, category_ids: [])
  end

  def read(result)
    title = result['title']
    url   = result['itemUrl']
    image_url = result['largeImageUrl']
    isbn = result['isbn']
    {
      title: title,
      url: url,
      image_url: image_url,
      isbn: isbn
    }
  end
end
