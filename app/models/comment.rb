class Comment < ApplicationRecord
  belongs_to :article
  has_many :replies, dependent: :destroy
end
