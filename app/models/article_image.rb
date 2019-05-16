class ArticleImage < ApplicationRecord
  belongs_to :article
  attachment :image

  validates :image, presence: true
end
