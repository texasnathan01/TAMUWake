module ApplicationHelper
  include UsersHelper
  include Pagy::Frontend

  def title(page_title)
    content_for(:title) { page_title }
  end
end
