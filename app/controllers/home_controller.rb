class HomeController < ApplicationController

	def about
	end

	def top
		@notices = Notice.order(created_at: :desc).first(8)
	end

end