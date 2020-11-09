class Article < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :category
  has_one_attached :image, dependent: :destroy

  validates :title, presence: true
  validates :title, length: { minimum: 6, maximum: 80 }

  validates :text, presence: true
  validates :text, length: { minimum: 10 }

  validates :category_id, presence: true

  validates :image, content_type: [ :png, :jpg, :jpeg ]
  validates :image, presence: true
end
