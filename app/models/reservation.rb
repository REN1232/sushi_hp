class Reservation < ApplicationRecord

	validates :customer_name, presence: true,length: {maximum: 20}
	validates :people, presence: true,length: { minimum: 0, maximum: 10}
	validates :reservation_time, presence: true
	validates :reservation_day, presence: true
	validates :phone_number, presence: true,length: { minimum: 10, maximum: 11 }

	#Eメール
	#英数字、アンダースコア (_)、プラス (+)、ハイフン (-)、ドット (.) のいずれかを少なくとも1文字以上繰り返す
	#+アットマーク,英小文字、数字、ハイフン、ドットのいずれかを少なくとも1文字以上繰り返す
	#+ドット,英小文字を少なくとも1文字以上繰り返す,大文字小文字を無視するオプション
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email,presence: true,format: {with: VALID_EMAIL_REGEX, allow_blank: true}

    #予約機能検索
	scope :search_date, -> (date) { where(reservation_day: date) }
	scope :lunch, -> { where("reservation_time < 4") }
	scope :dinner, -> { where("reservation_time > 3") }

	#予約機能
	enum people: %i[1 2 3 4 5 6 7 8 9 10]
	enum reservation_time: %i[11:00 12:00 13:00 14:00 17:00 18:00 19:00 20:00 21:00]
end