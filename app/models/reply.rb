class Reply < ApplicationRecord
  belongs_to :comment
  belongs_to :user

  validates :reply_text, length: { minimum: 1 }
  validates :reply_text, length: { maximum: 100 }
end
