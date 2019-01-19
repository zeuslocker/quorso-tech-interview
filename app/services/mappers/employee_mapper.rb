module Mappers
  class EmployeeMapper
    def self.call
      Employee.pluck(:id, :identifier).to_h.invert
    end
  end
end
