class Date::MonthDiff < Less::Interaction
	expects :date

	def run
		month_diff
	end

	private

	def month_diff
		(current_date.year * 12 + current_date.month) - (sportsbook_date.year * 12 + sportsbook_date.month)
	end

	def sportsbook_date
		Date.parse(date)
	end

	def current_date
		return Date.parse('2016-11-09') if Rails.env.test?
		Date.today
	end
end
