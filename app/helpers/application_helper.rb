module ApplicationHelper
  def flash_class_helper(my_type)
    {
      notice: 'success',
      success: 'success',
      error: 'danger',
      alert: 'danger',
      warning: 'warning'
    }[my_type.to_sym]
  end

  def flash_prefix_helper(my_type)
    {
      notice: 'Notice!',
      success: 'Success!',
      error: 'Error!',
      alert: 'Alert!',
      warning: 'Warning!'
    }[my_type.to_sym]
  end

  def user_navigator_links
    links = []

    if current_user.superadmin_role
      links << link_to('Dashboard', dashboard_index_path, class: 'nav-list__link')
      links << link_to('Administration', rails_admin.dashboard_path, class: 'nav-list__link')
    elsif current_user.moderator_role
      links << link_to('Dashboard', dashboard_index_path, class: 'nav-list__link')
      links << link_to('logout', destroy_user_session_path, method: :delete, class: 'nav-list__link')
    elsif current_user.user_role && !current_user.superadmin_role && !current_user.moderator_role
      links << link_to('add-article', new_article_path, class: 'nav-list__link')
      links << link_to('logout', destroy_user_session_path, method: :delete, class: 'nav-list__link')
    end
  end

  def logged_in_author?(article)
    if user_signed_in?
      current_user.id == article.author.id || current_user.superadmin_role || current_user.moderator_role
    else
      false
    end
  end

  def same_logged_in_user?(user)
    user_signed_in? && (current_user.id == user.id)
  end

  def voting(article)
    if user_signed_in? && current_user.likes?(article)
      link_to('Dislike', article_vote_path(article), class: 'dislike', method: :delete)
    else
      link_to('Like', article_vote_path(article), class: 'like', method: :post)
    end
  end
end
