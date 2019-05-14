class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :contacts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :replies, dependent: :destroy
  has_many :browsing_histories, dependent: :destroy

  validates :last_name, presence: { message: 'を入力してください' }
  validates :first_name, presence: { message: 'を入力してください' }

  attachment :user_image

  acts_as_paranoid

  def self.search(search)
    if search
      User.where(['last_name LIKE ?', "%#{search}%"])
      User.where(['first_name LIKE ?', "%#{search}%"])
    else
      User.all
    end
  end
end
