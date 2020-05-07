class HomeController < ApplicationController

	def top
		@notices = Notice.order(created_at: :desc).first(8)
	end

	def about
	end

	def store
	end

	def menus
	end

	def kodawari
	end

end