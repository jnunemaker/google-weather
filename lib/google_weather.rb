require 'httparty'
require File.dirname(__FILE__) + '/google_weather/data'

class GoogleWeather
  include HTTParty
  base_uri "www.google.com"
  Path = "/ig/api"

  attr_reader :param

  def initialize(value, options={})
    @param   = prep_param(value)
    @options = options
  end

  def locale
    @options[:locale] || :en
  end

  def weather
    @weather ||= self.class.get(Path, weather_options)['xml_api_reply']['weather']
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

  private

  def weather_options
    opts = {
      :query => {
        :weather => param,
        :hl => locale,
        :oe => 'utf-8'
      },
      :format => :xml,
    }
  end

  def prep_param(value)
    if value.kind_of?(Array)
      value = value.inject([]) do |result, element|
        result << (element * 1e6).to_i
        result
      end
      value = ",,,#{value[0]},#{value[1]}"
    else
      value
    end
  end
end
