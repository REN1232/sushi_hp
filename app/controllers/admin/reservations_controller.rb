class Admin::ReservationsController < ApplicationController

	def index
		if params[:link] == "new"
	    	@reservations = Reservation.where(created_at: Time.now.all_day).order(:reservation_day).page(params[:page]).per(10)
	    	@reservation = @reservations.count
	    	if @reservation == 0
	    		flash.now[:alert] = "予約はありません！"
			else
			end
	    elsif params[:link] == "today"
	       	@reservations = Reservation.where(reservation_day: Date.today).order(:reservation_time).page(params[:page]).per(10)
	       	@reservation = @reservations.count
	    	if @reservation == 0
	    		flash.now[:alert] = "予約はありません！"
			else
			end
	    else
	    	@reservations = Reservation.where.not("reservation_day < ?", Date.today).order(:reservation_day)
	    	@reservations = @reservations.search_date(params[:search_date])if params[:search_date].present?
	    	@reservations = @reservations.lunch if params[:reservation_type] == 'lunch'
	    	@reservations = @reservations.dinner if params[:reservation_type] == 'dinner'
			@reservations = @reservations.order(:reservation_time).page(params[:page]).per(10)
			@reservation = @reservations.count
	    	if @reservation == 0
	    		flash.now[:alert] = "予約はありません！"
			else
			end
			@search_time = params[:reservation_type]
			@search_day = params[:search_date]
	    end
	end

	def new
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
				flash.now[:alert] = "予約情報が確認できません！"
				render 'new'
			end
		else
			if 10 - a < 1
				flash.now[:alert] = "ご希望の日時ですとご予約は満席となります！"
				render 'new'
			else
				flash.now[:alert] = "ご希望の日時ですと予約可能人数は#{10-a}名までとなります！"
				render 'new'
			end
		end
	end

	def show
	end

	def edit
	end

	def update
		@reservation = Reservation.find(params[:id])
		if @reservation.update(reservation_params)
			redirect_to admin_reservation_path(@reservation.id)
		else
			render 'edit'
		end
	end

	def destroy
		@reservation = Reservation.find(params[:id])
	    @reservation.destroy
	    redirect_to admin_reservations_path
	end

	private

	def reservation_params
	    params.require(:reservation).permit(:customer_name,:people,:reservation_time,:reservation_day,:phone_number,:email,:request)
	end
end
