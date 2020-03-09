class ReservationsController < ApplicationController

	def new
		@reservation = Reservation.new
	end

	def show
		@reservation = Reservation.find(params[:id])
	end

	def create
		@reservation = Reservation.new(reservation_params)
		reservations = Reservation.where(reservation_day: @reservation.reservation_day).where(reservation_time: @reservation.reservation_time)
		a = 0
		reservations.each do |reservation|
			a += reservation.people
		end
		if a + @reservation.people <= 10

			if @reservation.save
				redirect_to reservation_path(@reservation.id)
			else
				flash.now[:notice] = "予約情報が確認できません！"
				render 'new'
			end
		else
			if 10 - a < 1
				flash.now[:notice] = "ご希望の日時ですとご予約は満席となります！"
				render 'new'
			else
				flash.now[:notice] = "ご希望の日時ですと予約可能人数は#{10-a}名までとなります！"
				render 'new'
			end
		end
	end

	def destroy
	    @reservation = Reservation.find(params[:id])
	    @reservation.destroy
	    redirect_to new_reservation_path
	end

	private

	def reservation_params
	    params.require(:reservation).permit(:customer_name,:people,:reservation_time,:reservation_day,:phone_number,:email,:request)
	end
end
