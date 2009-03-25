class GoogleWeather
  class Data
    attr_reader :data
    
    def initialize(data)
      @data = data
    end
    
    def method_missing(method)
      key = data[method.to_s]
      key && key['data']
    end
    
    def inspect
      data = @data.inject([]) { |collection, key| collection << "#{key[0]}: #{key[1]['data']}"; collection }.join("\n    ")
      "#<#{self.class}:0x#{object_id}\n    #{data}>"
    end
  end
  
  class ForecastInformation < Data; end
  class CurrentConditions < Data; end
  class ForecastCondition < Data; end
end