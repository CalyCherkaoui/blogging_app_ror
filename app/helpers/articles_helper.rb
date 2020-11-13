module ArticlesHelper
  def show_image_article(article)
    if article.image.attached?
      image_tag(article.display_image)
    else
      image_tag(asset_path('default_article.jpg'))
    end
  end
end
