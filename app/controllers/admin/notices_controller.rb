class Admin::NoticesController < ApplicationController

	before_action :authenticate_admin!

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
		@notice = Notice.find(params[:id])
	end

	def edit
		@notice = Notice.find(params[:id])
	end

	def update
		@notice = Notice.find(params[:id])
		if @notice.update(notice_params)
			redirect_to admin_notice_path(@notice.id)
		else
			render 'edit'
		end
	end

	def destroy
		@notice = Notice.find(params[:id])
		@notice.destroy
    	redirect_to admin_notices_path
	end

	private

	def notice_params
	    params.require(:notice).permit(:image,:title,:content)
	end


end
