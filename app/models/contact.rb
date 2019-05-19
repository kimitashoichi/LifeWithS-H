class Contact < ApplicationRecord
  belongs_to :user, optional: true

  validates :contact_title, length: { minimum: 1 }, length: { maximum: 30 }
  validates :contact_text, length: { minimum: 1 }, length: { maximum: 200 }
end
