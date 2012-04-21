require 'test_helper'

class GoogleWeatherTest < Test::Unit::TestCase
  context "Initialization" do
    should "require a value" do
      lambda { GoogleWeather.new }.should raise_error

      GoogleWeather.new(46544).param.should == 46544
    end

    should "convert lat, lng array into string of e6 formatted lat,lng values" do
      GoogleWeather.new([32.24959602450668,-110.8394506158091]).param.should == ',,,32249596,-110839450'
    end
  end

  context "Data" do
    setup do
      @data = GoogleWeather::Data.new({'foo' => {'data' => 'bar'}})
    end

    should "use method missing to get value for existing keys" do
      @data.foo.should == 'bar'
    end

    should "return nil for missing keys" do
      @data.foobar.should be(nil)
    end
  end


  context "Fetching" do
    context "with a zip code" do
      setup do
        FakeWeb.register_uri(:get, "http://www.google.com/ig/api?weather=46544", :body => fixture_file("fixtures/46544.xml"))
        @weather = GoogleWeather.new(46544)
      end

      should "have forecast information" do
        information = @weather.forecast_information
        information.city.should == 'Mishawaka, IN'
        information.postal_code.should == '46544'
        information.unit_system.should == 'US'
        information.forecast_date.should == '2009-03-24'
        information.current_date_time.should == '2009-03-25 04:16:27 +0000'
      end

      should "have current conditions" do
        conditions = @weather.current_conditions
        conditions.humidity.should == 'Humidity: 48%'
        conditions.icon.should == '/images/weather/cloudy.gif'
        conditions.temp_c.should == '17'
        conditions.temp_f.should == '62'
        conditions.condition.should == 'Overcast'
        conditions.wind_condition.should == 'Wind: SE at 11 mph'
      end

      should "have forecast conditions" do
        conditions = @weather.forecast_conditions
        conditions[0].low.should == '45'
        conditions[0].high.should == '67'
        conditions[0].icon.should == '/images/weather/mostly_sunny.gif'
        conditions[0].condition.should == 'Partly Sunny'
        conditions[0].day_of_week.should == 'Tue'
        conditions[1].low.should == '34'
        conditions[1].high.should == '52'
        conditions[1].icon.should == '/images/weather/mostly_sunny.gif'
        conditions[1].condition.should == 'Mostly Sunny'
        conditions[1].day_of_week.should == 'Wed'
      end
    end

    context "with a string" do
      setup do
        FakeWeb.register_uri(:get, "http://www.google.com/ig/api?weather=London%2CUK", :body => fixture_file("fixtures/london.xml"))
        @weather = GoogleWeather.new('London,UK')
      end

      should "have forecast information" do
        information = @weather.forecast_information
        information.city.should == 'london,uk'
        information.postal_code.should == 'london,uk'
        information.unit_system.should == 'US'
        information.forecast_date.should == '2012-04-21'
        information.current_date_time.should == '1970-01-01 00:00:00 +0000'
      end

      should "have current conditions" do
        conditions = @weather.current_conditions
        conditions.humidity.should == 'Humidity: 81%'
        conditions.icon.should == '/ig/images/weather/sunny.gif'
        conditions.temp_c.should == '6'
        conditions.temp_f.should == '43'
        conditions.condition.should == 'Clear'
        conditions.wind_condition.should == 'Wind: SW at 10 mph'
      end

      should "have forecast conditions" do
        conditions = @weather.forecast_conditions
        conditions[0].low.should == '43'
        conditions[0].high.should == '55'
        conditions[0].icon.should == '/ig/images/weather/chance_of_storm.gif'
        conditions[0].condition.should == 'Chance of Storm'
        conditions[0].day_of_week.should == 'Sat'
        conditions[1].low.should == '43'
        conditions[1].high.should == '57'
        conditions[1].icon.should == '/ig/images/weather/chance_of_storm.gif'
        conditions[1].condition.should == 'Chance of Storm'
        conditions[1].day_of_week.should == 'Sun'
      end
    end

    context "with latitude, longitude array" do
      setup do
        FakeWeb.register_uri(:get, "http://www.google.com/ig/api?weather=%2C%2C%2C32221700%2C110925800", :body => fixture_file("fixtures/coords.xml"))
        @weather = GoogleWeather.new(',,,32221700,110925800')
      end

      should "have forecast information" do
        information = @weather.forecast_information
        information.city.should == ''
        information.postal_code.should == ''
        information.latitude_e6.should == '32221700'
        information.longitude_e6.should == '110925800'
        information.unit_system.should == 'US'
        information.forecast_date.should == '2012-04-21'
        information.current_date_time.should == '2012-04-21 17:00:00 +0000'
      end

      should "have current conditions" do
        conditions = @weather.current_conditions
        conditions.humidity.should == 'Humidity: 69%'
        conditions.icon.should == '/ig/images/weather/mostly_cloudy.gif'
        conditions.temp_c.should == '19'
        conditions.temp_f.should == '66'
        conditions.condition.should == 'Mostly Cloudy'
        conditions.wind_condition.should == 'Wind: SE at 2 mph'
      end

      should "have forecast conditions" do
        conditions = @weather.forecast_conditions
        conditions[0].low.should == '54'
        conditions[0].high.should == '84'
        conditions[0].icon.should == '/ig/images/weather/sunny.gif'
        conditions[0].condition.should == 'Clear'
        conditions[0].day_of_week.should == 'Sat'
        conditions[1].low.should == '55'
        conditions[1].high.should == '88'
        conditions[1].icon.should == '/ig/images/weather/sunny.gif'
        conditions[1].condition.should == 'Clear'
        conditions[1].day_of_week.should == 'Sun'
      end
    end
  end
end

__END__

Example hash that comes back from Google

{
  "xml_api_reply"=> {
    "version"=>"1",
    "weather"=> {
      "mobile_row"=>"0",
      "mobile_zipped"=>"1",
      "module_id"=>"0",
      "forecast_information"=>{
        "city"=>{"data"=>"Mishawaka, IN"},
        "postal_code"=>{"data"=>"46544"},
        "longitude_e6"=>{"data"=>""},
        "current_date_time"=>{"data"=>"2009-03-25 04:16:27 +0000"},
        "latitude_e6"=>{"data"=>""},
        "forecast_date"=>{"data"=>"2009-03-24"},
        "unit_system"=>{"data"=>"US"}
      },
      "current_conditions"=> {
        "humidity"=>{"data"=>"Humidity: 48%"},
        "icon"=>{"data"=>"/images/weather/cloudy.gif"},
        "condition"=>{"data"=>"Overcast"},
        "temp_c"=>{"data"=>"17"},
        "wind_condition"=>{"data"=>"Wind: SE at 11 mph"},
        "temp_f"=>{"data"=>"62"}
      },
      "tab_id"=>"0",
      "forecast_conditions"=>[
        {
          "high"=>{"data"=>"67"},
          "day_of_week"=>{"data"=>"Tue"},
          "icon"=>{"data"=>"/images/weather/mostly_sunny.gif"},
          "condition"=>{"data"=>"Partly Sunny"},
          "low"=>{"data"=>"45"}
        },
        {
          "high"=>{"data"=>"52"},
          "day_of_week"=>{"data"=>"Wed"},
          "icon"=>{"data"=>"/images/weather/mostly_sunny.gif"},
          "condition"=>{"data"=>"Mostly Sunny"},
          "low"=>{"data"=>"34"}
        },
        {
          "high"=>{"data"=>"54"},
          "day_of_week"=>{"data"=>"Thu"},
          "icon"=>{"data"=>"/images/weather/mostly_sunny.gif"},
          "condition"=>{"data"=>"Mostly Sunny"},
          "low"=>{"data"=>"36"}
        },
        {
          "high"=>{"data"=>"56"},
          "day_of_week"=>{"data"=>"Fri"},
          "icon"=>{"data"=>"/images/weather/mostly_sunny.gif"},
          "condition"=>{"data"=>"Mostly Sunny"},
          "low"=>{"data"=>"38"}
        }
      ]
    }
  }
}