package facturation

/**
 * @author gelleouet <gregory.elleouet@gmail.com>
 *
 */
class DateUtils {
	static final String FORMAT_DATE_USER = "dd/MM/yyyy"


	static Date lastDayInMonth(Date date) {
		Calendar calendar = Calendar.getInstance()
		calendar.setTime(date)
		calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMaximum(Calendar.DAY_OF_MONTH))
		return calendar.getTime().clearTime()
	}


	static Date lastDayInWeek(Date date) {
		Calendar calendar = Calendar.getInstance()
		calendar.setTime(date)

		if (calendar.get(Calendar.DAY_OF_WEEK) != Calendar.SUNDAY) {
			calendar.add(Calendar.DAY_OF_YEAR, 7 - (calendar.get(Calendar.DAY_OF_WEEK) - 1))
		}

		return calendar.getTime()
	}


	static Date lastDayInYear(Date date) {
		Calendar calendar = Calendar.getInstance()
		calendar.setTime(date)
		calendar.set(Calendar.DAY_OF_MONTH, 31)
		calendar.set(Calendar.MONTH, Calendar.DECEMBER)
		return calendar.getTime().clearTime()
	}


	static Date firstDayInWeek(Date date) {
		Calendar calendar = Calendar.getInstance()
		calendar.setTime(date)

		if (calendar.get(Calendar.DAY_OF_WEEK) == Calendar.SUNDAY) {
			calendar.add(Calendar.DAY_OF_YEAR, -6)
		} else {
			calendar.add(Calendar.DAY_OF_YEAR, -(calendar.get(Calendar.DAY_OF_WEEK) - 2))
		}

		return calendar.getTime()
	}


	static Date firstDayInMonth(Date date) {
		Calendar calendar = Calendar.getInstance()
		calendar.setTime(date)
		calendar.set(Calendar.DAY_OF_MONTH, 1)
		return calendar.getTime().clearTime()
	}


	static Date firstDayInYear(Date date) {
		Calendar calendar = Calendar.getInstance()
		calendar.setTime(date)
		calendar.set(Calendar.DAY_OF_YEAR, 1)
		return calendar.getTime().clearTime()
	}
}
