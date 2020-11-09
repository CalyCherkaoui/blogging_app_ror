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

  def cover_image
    self.image.variant(resize: '200x200').processed
  end

  def hero_image
    self.image.variant(resize: '300x300').processed
  end

  def display_image
    self.image.variant(resize: '1000x1000').processed
  end
end
