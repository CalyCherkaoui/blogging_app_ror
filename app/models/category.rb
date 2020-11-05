class Category < ApplicationRecord
  has_many :articles, -> { order(created_at: :desc) }
end
