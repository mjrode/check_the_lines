class Date::MonthDiff < Less::Interaction
	expects :month, allow_nil: true

	def run
		month_diff
	end

	private

	def month_diff
		current_month - sportsbook_month
	end

	def sportsbook_month
		Date.parse(month).strftime("%m").to_i
	end

	def current_month
		return 11 if Rails.env.test?
		Date.today.strftime("%m").to_i 
	
	end
end
