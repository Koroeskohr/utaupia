module UtauloidsHelper
	def get_search_date_options
		{
			one_day: "1 day",
			three_days: "3 days",
			one_week: "1 week",
			one_month: "1 month",
			six_months: "6 months"
		}
	end

	def get_query_date(value)
		return case value
		when 'one_day'
			1.day.ago
		when 'three_days'
			3.days.ago
		when 'one_week'
			1.week.ago
		when 'one_month'
			1.month.ago
		when 'six_months'
			6.months.ago
		else
			Time.now
		end
	end
end
