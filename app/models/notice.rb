class Notice < ApplicationRecord

	attachment :image
	validates :title, presence: true
	validates :content, presence: true
end
