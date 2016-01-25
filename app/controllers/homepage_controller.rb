class HomepageController < ApplicationController
	def index
		homepage_params = Homepage.first

		@utauloid_showcase = Utauloid.find(homepage_params[:utauloid_showcase])
		@utauloids = Utauloid.limit(5)
	end
end
