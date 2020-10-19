class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.build(comment_params)
    @post = @comment.post
    @user = @post.user.id
    if @comment.save
      @post.save_notification_comment!(current_user, @comment.id, @user)
      redirect_back(fallback_location: root_path)
    else
      render 'posts/show'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :post_id, :content)
  end
end
