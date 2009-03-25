require 'test_helper'

class GoogleWeatherTest < Test::Unit::TestCase
  context "Initialization" do
    should "require a zip code" do
      lambda { GoogleWeather.new }.should raise_error
      
      GoogleWeather.new(46544).zip.should == 46544
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
    setup do
      FakeWeb.register_uri(:get, "http://www.google.com/ig/api?weather=46544", :string => File.read("fixtures/46544.xml"))
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