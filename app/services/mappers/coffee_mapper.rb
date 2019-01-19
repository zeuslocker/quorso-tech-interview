module Mappers
  class CoffeeMapper
    COFFEE_MAP = {
      'Espresso'=> %w(C01 ESP),
      'Cappuccino'=> %w(C02 CAP),
      'Flat White'=> %w(C03 FTW),
      'Americano'=> %w(C04 AME),
      'Caffé Mocha'=> %w(C05 CMO)
    }

    def self.call
      identifiers = Coffee.pluck(:id, :name).to_h.invert

      COFFEE_MAP.reduce({}) do |acc, (key, value)|
        value.each{|x| acc[x] = identifiers[key]}
        acc
      end
    end
  end
end
