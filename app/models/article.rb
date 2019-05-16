class Article < ApplicationRecord
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :article_images, dependent: :destroy
  has_many :browsing_histories, dependent: :destroy

  accepts_attachments_for :article_images, attachment: :image

  validates :article_title,   length: { minimum: 10 }
  validates :article_text,   length: { minimum: 30 }
  validates :genre, presence: true

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def self.browse_all_ranks
    if BrowsingHistory.group(:article_id).order('count(article_id) desc').limit(30).pluck(:article_id).nil?
      Article.find(BrowsingHistory.group(:article_id).order('count(article_id) desc').limit(30).pluck(:article_id))
    end
 end
end
