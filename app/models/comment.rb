class Comment < ApplicationRecord
  belongs_to :article
  belongs_to :user
  has_many :replies, dependent: :destroy

  validates :comment_text, length: { minimum: 1 }
  validates :comment_text, length: { maximum: 100 }
end
