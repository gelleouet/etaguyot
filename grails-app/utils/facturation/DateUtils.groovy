package facturation

import java.text.SimpleDateFormat

import groovy.time.TimeCategory

/**
 * @author gelleouet <gregory.elleouet@gmail.com>
 *
 */
class DateUtils {
	static final String FORMAT_DATE_USER = "dd/MM/yyyy"
	static final String FORMAT_DATE_PICKER = "yyyy-MM-dd"


	static Date parseRange(String range, DateRangePartEnum part) {
		if (!range) {
			return null
		}

		def parts = range.split("-")

		if (parts.length != 2) {
			return null
		}

		if (part == DateRangePartEnum.start) {
			return parseDateUser(parts[0].trim())
		} else {
			return parseDateUser(parts[1].trim())
		}
	}


	static Date parseDateUser(String source) {
		new SimpleDateFormat(FORMAT_DATE_USER).parse(source)
	}


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
	
	
	/**
	 * Décale l'année sur la date
	 *
	 * @param date
	 * @param inc
	 * @return
	 */
	static Date incDay(Date date, int inc) {
		Date result

		if (date) {
			use(TimeCategory) {
				result = date + inc.days
			}
		}

		return result
	}
	
	
	/**
	 * Décale l'année sur la date
	 *
	 * @param date
	 * @param inc
	 * @return
	 */
	static Date incYear(Date date, int inc) {
		Date result

		if (date) {
			use(TimeCategory) {
				result = date + inc.years
			}
		}

		return result
	}
}
