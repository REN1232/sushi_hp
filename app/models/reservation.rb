class Reservation < ApplicationRecord

	validates :customer_name, presence: true
	validates :people, presence: true
	validates :reservation, presence: true
	validates :phone_number, presence: true
	validates :email, presence: true
end
