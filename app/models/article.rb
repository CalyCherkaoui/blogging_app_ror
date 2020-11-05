class Article < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :category

  validates :title, presence: true
  validates :title, length: {
    minimum: 6,
    maximum: 80
  }

  validates :text, presence: true
  validates :text, length: {
    minimum: 10
  }
  validates :category_id, presence: true
end
