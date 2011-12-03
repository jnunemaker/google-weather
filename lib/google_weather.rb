require 'httparty'
require File.dirname(__FILE__) + '/google_weather/data'

class GoogleWeather  
  include HTTParty
  base_uri "www.google.com"
  
  attr_reader :zip
  attr_reader :locale

  def initialize(zip, locale = :en)
    @zip = zip
    @locale = locale
  end
  
  def weather
    @weather ||= self.class.get("/ig/api", :query => {:weather => @zip, :hl => @locale, :oe => 'utf-8'}, :format => :xml)['xml_api_reply']['weather']
  end
  
  def forecast_information
    @forecast_information ||= ForecastInformation.new(weather['forecast_information'])
  end
  
  def current_conditions
    @current_conditions ||= CurrentConditions.new(weather['current_conditions'])
  end
  
  def forecast_conditions
    @forecast_conditions ||= weather['forecast_conditions'].map { |cond| ForecastCondition.new(cond) }
  end
end
