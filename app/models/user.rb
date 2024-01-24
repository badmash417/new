class User < ApplicationRecord
	belongs_to :role
	has_one_attached :image
end
