class ReservationsController < ApplicationController

	def new
		@reservation = Reservation.new
		@peoples = Reservation.people.keys
		@reservation_times = Reservation.reservation_times.keys
	end

	def show
		@reservation = Reservation.find(params[:id])
	end

	def create
		@reservation = Reservation.new(reservation_params)
		#予約人数確認
		reservations = Reservation.where(reservation_day: @reservation.reservation_day).where(reservation_time: @reservation.reservation_time)
		a = 0
		reservations.each do |reservation|
			a += reservation.people.to_i
		end
		#合計10人以下
		if a + @reservation.people.to_i <= 10

			if params[:back]
				@peoples = Reservation.people.keys
				@reservation_times = Reservation.reservation_times.keys
	      		render 'new'
			elsif @reservation.save
				redirect_to reservation_path(@reservation.id)
			else
				@peoples = Reservation.people.keys
				@reservation_times = Reservation.reservation_times.keys
				render 'new'
			end
		else
			if 10 - a < 1
				flash.now[:alert] = "ご希望の日時ですとご予約は満席となります！"
				@peoples = Reservation.people.keys
				@reservation_times = Reservation.reservation_times.keys
				render 'new'
			else
				flash.now[:alert] = "ご希望の日時ですと予約可能人数は#{10-a}名までとなります！"
				@peoples = Reservation.people.keys
				@reservation_times = Reservation.reservation_times.keys
				render 'new'
			end
		end
	end

	def destroy
	    @reservation = Reservation.find(params[:id])
	    @reservation.destroy
	    redirect_to delete_path
	end

	def delete
	end

	def confirm
		@reservation = Reservation.new(reservation_params)
		@peoples = Reservation.people.keys
		@reservation_times = Reservation.reservation_times.keys
  		render "new" if @reservation.invalid?
	end

	def back
		@reservation = Reservation.new(reservation_params)
		@peoples = Reservation.people.keys
		@reservation_times = Reservation.reservation_times.keys
    	render "new"
    end

	def ajax
		#変数に選ばれたデータを入れる
		@reservation = Reservation.new(reservation_day:params[:reservation_day], reservation_time:params[:reservation_time],people:params[:people])
		#人数を絞る
		reservation_peoples = Reservation.where(reservation_day:params[:reservation_day]).where(reservation_time:params[:reservation_time])
		a = 0
		reservation_peoples.each do |reservation|
			a += reservation.people.to_i
		end
		a = 10 - a
		@peoples = Reservation.people.first(a).map{ |k,v| [k, v + 1] }

		#時間帯を絞る
		reservation_times = Reservation.where(reservation_day:params[:reservation_day])
		reservation_times1 = reservation_times.where(reservation_time:"11:00")
		b = params[:people].to_i
		reservation_times1.each do |reservation|
			b += reservation.people.to_i
		end

		reservation_times2 = reservation_times.where(reservation_time:"12:00")
		c = params[:people].to_i
		reservation_times2.each do |reservation|
			c += reservation.people.to_i
		end

		reservation_times3 = reservation_times.where(reservation_time:"13:00")
		d = params[:people].to_i
		reservation_times3.each do |reservation|
			d += reservation.people.to_i
		end

		reservation_times4 = reservation_times.where(reservation_time:"14:00")
		e = params[:people].to_i
		reservation_times4.each do |reservation|
			e += reservation.people.to_i
		end

		reservation_times5 = reservation_times.where(reservation_time:"17:00")
		f = params[:people].to_i
		reservation_times5.each do |reservation|
			f += reservation.people.to_i
		end

		reservation_times6 = reservation_times.where(reservation_time:"18:00")
		g = params[:people].to_i
		reservation_times6.each do |reservation|
			g += reservation.people.to_i
		end

		reservation_times7 = reservation_times.where(reservation_time:"19:00")
		h = params[:people].to_i
		reservation_times7.each do |reservation|
			h += reservation.people.to_i
		end

		reservation_times8 = reservation_times.where(reservation_time:"20:00")
		i = params[:people].to_i
		reservation_times8.each do |reservation|
			i += reservation.people.to_i
		end

		reservation_times9 = reservation_times.where(reservation_time:"21:00")
		j = params[:people].to_i
		reservation_times9.each do |reservation|
			j += reservation.people.to_i
		end

		if b < 11
			b = "11:00"
		else
			b = 11
		end

		if c < 11
			c = "12:00"
		else
			c = 11
		end

		if d < 11
			d = "13:00"
		else
			d = 11
		end

		if e < 11
			e = "14:00"
		else
			e = 11
		end

		if f < 11
			f = "17:00"
		else
			f = 11
		end

		if g < 11
			g = "18:00"
		else
			g = 11
		end

		if h < 11
			h = "19:00"
		else
			h = 11
		end

		if i < 11
			i = "20:00"
		else
			i = 11
		end

		if j < 11
			j = "21:00"
		else
			j = 11
		end

		@reservation_times = Reservation.reservation_times.slice(b,c,d,e,f,g,h,i,j).keys
	end

	private

	def reservation_params
	    params.require(:reservation).permit(:customer_name,:people,:reservation_time,:reservation_day,:phone_number,:email,:request)
	end
end
