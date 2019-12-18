package facturation

import grails.databinding.converters.ValueConverter
import groovy.transform.CompileStatic

@CompileStatic
class DoubleValueConverter implements ValueConverter {

	@Override
	boolean canConvert(Object value) {
		return value instanceof String && value.toString().isDouble()
	}

	@Override
	Object convert(Object value) {
		// le canConvert protège des valeurs nulles et "non double"
		return Double.valueOf(value.toString())
	}

	@Override
	Class<?> getTargetType() {
		return Double
	}
}
