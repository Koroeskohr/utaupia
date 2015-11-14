class UtauloidsController < ApplicationController
	def show
		@utauloid = Utauloid.find(params[:id])
	end

	def new
		@utauloid = Utauloid.new
	end

end
