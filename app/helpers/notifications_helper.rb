module NotificationsHelper
  def unchecked_notifications
    @notifications = current_user.opponent_notifications.where(checked: false)
  end
end
