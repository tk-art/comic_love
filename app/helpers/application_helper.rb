module ApplicationHelper
  def full_title(page_title: '')
    if page_title.blank?
      Constants::BASE_TITLE
    else
      "#{page_title} - #{Constants::BASE_TITLE}"
    end
  end

  def current_user?(user)
    user && user == current_user
  end
end
