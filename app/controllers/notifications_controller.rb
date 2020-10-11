class NotificationsController < ApplicationController
  def index
    @notifications = current_user.opponent_notifications.includes(:post, :visitor, :visited)
                                 .page(params[:page]).per(15)
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
  end

  def destroy
    @notifications = current_user.opponent_notifications.destroy_all
    redirect_to user_path(current_user)
  end
end
