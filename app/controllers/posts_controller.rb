class PostsController < ApplicationController
  def new
    @isbn = session[:isbn]
  end

  def search
    @items = []
    if params[:keyword]
      item = RakutenWebService::Books::Book.search({
                                                     title: params[:keyword],
                                                     hits: 10
                                                   })

      item.each do |i|
        item = current_user.posts.build(read(i))
        @items << item
      end
    end
  end

  def isbn
    if params[:isbn]
      session[:isbn] = params[:isbn]
      redirect_to new_post_url
    else
      flash[:alert] = '投稿に失敗しました！'
      render 'search'
    end
  end

  def show; end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:notice] = '投稿に成功しました！'
      redirect_to user_url(current_user)
    else
      flash[:alert] = '投稿に失敗しました！'
      render 'new'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = '削除が成功しました！'
    redirect_to user_path(current_user)
  end

  private

  def post_params
    params.permit(:user_id, :content, :isbn, :title, :url, :image_url)
  end

  def read(result)
    title = result['title']
    url   = result['itemUrl']
    image_url = result['mediumImageUrl']
    isbn = result['isbn']
    {
      title: title,
      url: url,
      image_url: image_url,
      isbn: isbn
    }
  end
end
