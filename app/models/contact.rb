class Contact < ApplicationRecord
  belongs_to :user, optional: true

  validates :contact_name, presence: true
  validates :contact_title, length: { minimum: 1 }
  validates :contact_title, length: { maximum: 30 }
  validates :contact_text, length: { minimum: 1 }
  validates :contact_text, length: { maximum: 200 }
end
