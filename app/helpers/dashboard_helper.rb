module DashboardHelper
  def latest_added_article_dashboard(article)
    if article.present?
      link_to("#{article.title}...", article_path(article))
    else
      'No article added yet!'
    end
  end

  def most_voted_article_dashboard(article)
    if article.present?
      link_to("#{article.title}...", article_path(article))
    else
      'No article voted yet!'
    end
  end

  def latest_added_category_dashboard(category)
    if category.present?
      link_to(category.name.to_s, category_path(category))
    else
      'No category added yet!'
    end
  end

  #   def article_released_dashboard(articles)

  #     if articles.empty?
  #       'No articles yet'
  #     else
  #       articles.each do |article|
  #         render 'dashboard/card', article: article
  #       end
  #     end

  #   end

  #   <% @articles_released.each do |article| %>

  #     <%= render 'dashboard/card', article: article%>

  # <% end %>
end
