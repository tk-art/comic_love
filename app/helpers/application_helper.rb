module ApplicationHelper
  def full_title(page_title: "")
    if page_title.blank?
      Constants::BASE_TITLE
    else
      "#{page_title} - #{Constants::BASE_TITLE}"
    end
  end
end
