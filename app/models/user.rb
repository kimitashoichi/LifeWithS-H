class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :entries
  has_many :messages, dependent: :destroy
  has_many :contacts, dependent: :destroy
  has_many :favorites, dependent: :destroy

  attachment :user_image

  acts_as_paranoid
end
