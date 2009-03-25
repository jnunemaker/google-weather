require 'rubygems'
gem 'httparty'
require 'httparty'
require File.dirname(__FILE__) + '/google_weather/data'

class GoogleWeather  
  include HTTParty
  base_uri "www.google.com"
  
  attr_reader :zip
  
  def initialize(zip)
    @zip = zip
  end
  
  def weather
    @weather ||= self.class.get("/ig/api", :query => {:weather => @zip}, :format => :xml)['xml_api_reply']['weather']
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
