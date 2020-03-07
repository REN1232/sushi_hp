class Admin::noticesController < ApplicationController
	def index
	end

	def new
	end

	def create
	end

	def edit
	end

	def update
	end

	def destroy
	end

	private

	def notice_params
	    params.require(:notice).permit(:image_id,:title,:content)
	end


end
