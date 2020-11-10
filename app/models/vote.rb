class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :article

  validates :user_id, presence: true
  validates :article_id, presence: true
  validates :article_id, uniqueness: { scope: :user_id }

  def self.most_voted_article
    articles_votes = Vote.group(:article_id).count
    article_max_vote_id = articles_votes.key(articles_votes.values.max)
    if article_max_vote_id
      Article.find(article_max_vote_id)
    else
      Article.last
    end
  end
end
