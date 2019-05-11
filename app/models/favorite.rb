class Favorite < ApplicationRecord
	belongs_to :user
	bolongs_to :article
end
