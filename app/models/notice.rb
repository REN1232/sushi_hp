class Notice < ApplicationRecord

	attachment :image_id
	validates :title, presence: true
	validates :content, presence: true
end
