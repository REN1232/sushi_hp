class NoticesController < ApplicationController

	def index
		@notices = Notice.page(params[:page]).per(3)
	end

	def show
		@notice = Notice.find(params[:id])
	end

end
