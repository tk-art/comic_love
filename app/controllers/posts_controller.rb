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
    @post = current_user.posts.find(params[:id])
  end

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
    @post = current_user.posts.find(params[:id])
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
