class Article < ApplicationRecord
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :article_images, dependent: :destroy
  has_many :browsing_histories, dependent: :destroy

  accepts_attachments_for :article_images, attachment: :image

  validates :article_title, length: { minimum: 10 }
  validates :article_title, length: { maximum: 35 }
  validates :article_text, length: { minimum: 50 }
  validates :article_text, length: { maximum: 2000 }
  validates :genre, presence: true
  validates :link_name, presence: true
  validates :movie_url, presence: true
  validates :article_url, presence: true

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def self.search(search)
    if search
      Article.where(['article_title LIKE ?', "%#{search}%"])
    else
      Article.all
    end
  end
end
