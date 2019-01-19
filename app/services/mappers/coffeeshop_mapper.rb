module Mappers
  class CoffeeshopMapper
    def self.call
      Coffeeshop.pluck(:id, :identifier).to_h.invert
    end
  end
end
