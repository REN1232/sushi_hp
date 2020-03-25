class Notice < ApplicationRecord

	attachment :image
	validates :title, presence: true
	validates :content, length: {maximum: 200}

	#お知らせ詳細の前後の投稿リンク
	def previous
	    Notice.where("id < ?",id).order("id DESC").first
	end
	def next
	    Notice.where("id > ?", id).order("id ASC").first
	end
end
