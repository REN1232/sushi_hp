class NoticesController < ApplicationController

	def index
		@notices = Notice.order(created_at: :desc).page(params[:page]).per(4)
	end

	def show
		@notice = Notice.find(params[:id])
	end

end
