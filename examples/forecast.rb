require File.dirname(__FILE__) + '/../lib/google_weather'
require 'pp'

weather = GoogleWeather.new(46544)

forecast = weather.forecast_conditions[0]
puts forecast.day_of_week, forecast.low, forecast.high, forecast.condition

pp weather.forecast_information
puts
pp weather.current_conditions
puts
pp weather.forecast_conditions