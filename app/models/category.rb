class Category < ApplicationRecord
  has_many :articles, -> { order(created_at: :desc) }

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :name, length: {
    minimum: 2,
    maximum: 20
  }
  validates :priority, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
