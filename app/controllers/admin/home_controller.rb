class Admin::HomeController < ApplicationController
	before_action :authenticate_admin!
	def top
	end

	def about
	end

	def kodawari
	end

	def menus
	end

	def store
	end

end