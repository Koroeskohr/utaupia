class UtauloidsController < ApplicationController
	def show
		@utauloid = Utauloid.find(params[:id])		
	end

end
