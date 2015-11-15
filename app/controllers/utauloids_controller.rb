class UtauloidsController < ApplicationController
	def show
		@utauloid = Utauloid.find(params[:id])
	end

	def new
		@utauloid = Utauloid.new
	end

	def create
		@utauloid = Utauloid.new(utauloid_params)
		if @utauloid.save
			redirect_to @utauloid
		end
	end

	def edit
		@utauloid = Utauloid.find(params[:id])
	end

	private
		def utauloid_params
			params.require(:utauloid).permit(:age, :gender, :name)
		end
end
