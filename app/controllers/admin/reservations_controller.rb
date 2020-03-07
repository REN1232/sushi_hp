class Admin::ReservationsController < ApplicationController

	def index
	end

	def new
	end

	def create
	end

	def show
	end

	def edit
	end

	def update
	end

	def destroy
	end

	private

	def reservation_params
	    params.require(:reservation).permit(:customer_name,:people,:reservation,:phone_number,:email,:request)
	end
end
