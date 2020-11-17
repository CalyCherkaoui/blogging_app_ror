module DashboardHelper
  def latest_added_article_dashboard(article)
    if article.present?
      link_to("#{article.title}...", article_path(article))
    else
      link_to('No article added yet!', root_path)
    end
  end

  def most_voted_article_dashboard(article)
    if article.present?
      link_to("#{article.title}...", article_path(article))
    else
      link_to('No article voted yet!', root_path)
    end
  end

  def latest_added_category_dashboard(category)
    if category.present?
      link_to(category.name.to_s, category_path(category))
    else
      link_to('No category added yet!', root_path)
    end
  end
end
