module UtauloidsHelper
	def get_search_date_options
		{
			inf_one_month: "< 1 month",
			inf_six_months: "< 6 months",
			inf_one_year: "< 1 year",
			sup_one_year: "> 1 year"
		}
	end

	def get_query_date(value)
		return case value
		when 'inf_one_month'
			1.month.ago
		when 'inf_six_months'
			6.months.ago
		when 'inf_one_year'
			1.year.ago
		when 'sup_one_year'
			1.year.ago
		else
			Time.now
		end
	end
end
