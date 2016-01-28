class HomepageController < ApplicationController
	def index
		homepage_params = Homepage.first

		if !homepage_params.utauloid_showcase.nil?
			@utauloid_showcase = homepage_params.utauloid_showcase
		end
		@utauloids = Utauloid.order("id DESC").limit(5)
	end
end
