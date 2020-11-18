class Article < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :category
  has_one_attached :image, dependent: :destroy
  has_many :votes, dependent: :destroy

  validates :title, presence: true
  validates :title, length: { minimum: 6, maximum: 80 }

  validates :text, presence: true
  validates :text, length: { minimum: 10 }

  validates :category_id, presence: true

  validates :image, content_type: %i[png jpg jpeg]
  validates :image, presence: true

  scope :heros, -> { order(created_at: :desc).includes(:author) }
  scope :ordred_by_votes, -> { order(votes_count: :desc).includes(:category) }
  scope :with_attached_image, -> { includes(image_attachment: :blob) }
  scope :with_image_category, -> { includes(image_attachment: :blob).includes(:category) }

  scope :released_with_attachements, -> { heros.includes(image_attachment: :blob).includes(:category) }

  def votes_count
    votes.count
  end

  def cover_image
    image.variant(resize_to_limit: [200, nil])
  end

  def hero_image
    image.variant(resize_to_limit: [600, nil])
  end

  def display_image
    image.variant(resize_to_limit: [1000, nil])
  end
end
