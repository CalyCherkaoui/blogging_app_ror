class User < ApplicationRecord
  has_many :articles, foreign_key: :author_id, class_name: 'Article'
  has_many :votes, dependent: :destroy

  has_many :liked_articles, through: :votes, source: :article

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true

  def likes?(article)
    article.votes.where(user_id: id).any?
  end

  def like_article(article)
    liked_articles << article
  end

  def dislike_article(article)
    liked_articles.delete(article)
  end
end
