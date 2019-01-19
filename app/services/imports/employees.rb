module Imports
  class Employees
    def self.run(file_path)
      coffeeshops = Mappers::CoffeeshopMapper.call

      CSV.foreach(file_path, headers: true) do |row|
        Employee.create!(
          name: row.fetch('name'),
          identifier: row.fetch('employee id'),
          coffeeshop_id: coffeeshops.fetch(row.fetch('coffeeshop'))
        )
      end
    end
  end
end
