class Admin::NoticesController < ApplicationController

	before_action :authenticate_admin!

	before_action :find_notice, only: [:show,:edit,:destroy,:update]

	def index
		@notices = Notice.order(created_at: :desc).page(params[:page]).per(8)
	end

	def new
		@notice = Notice.new
	end

	def create
		@notice = Notice.new(notice_params)
		if @notice.save #入力されたデータをdbに保存する。
	      redirect_to admin_notices_path
	    else
	      render 'new'
	    end
	end

	def show
	end

	def edit
	end

	def update
		if @notice.update(notice_params)
			redirect_to admin_notice_path(@notice.id)
		else
			render 'edit'
		end
	end

	def destroy
		@notice.destroy
    	redirect_to admin_notices_path
	end

	private

	def notice_params
	    params.require(:notice).permit(:image,:title,:content)
	end

	def find_notice
		@notice = Notice.find(params[:id])
	end
end
