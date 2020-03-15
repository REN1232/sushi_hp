class Reservation < ApplicationRecord

	validates :customer_name, presence: true
	validates :people, presence: true
	validates :reservation_time, presence: true
	validates :reservation_day, presence: true
	validates :phone_number, presence: true
	validates :email, presence: true

	scope :search_date, -> (date) { where(reservation_day: date) }
	scope :lunch, -> { where("reservation_time < '15:00'") }
	scope :dinner, -> { where("reservation_time > '15:00'") }
end
