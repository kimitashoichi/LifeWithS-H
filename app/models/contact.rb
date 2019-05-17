class Contact < ApplicationRecord
  belongs_to :user, optional: true

  validates :contact_title, length: { minimum: 5 }, length: { maximum: 30 }
  validates :contact_text, length: { minimum: 10 }, length: { maximum: 200 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :contact_email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
end
