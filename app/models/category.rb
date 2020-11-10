class Category < ApplicationRecord
  has_many :articles

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :name, length: {
    minimum: 2,
    maximum: 20
  }
  validates :priority, presence: true, numericality: { only_integer: true, greater_than: 0 }

  scope :priority_sorted, -> { order(priority: :asc) }

  scope :importants, -> { priority_sorted.limit(4) }
  scope :important_with_articles, -> { importants.includes(articles: [image_attachment: :blob]) }

  def latest_article
    articles.heros.first
  end
end
