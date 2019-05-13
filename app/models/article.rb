class Article < ApplicationRecord
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :article_images, dependent: :destroy

  accepts_attachments_for :article_images, attachment: :image

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end
