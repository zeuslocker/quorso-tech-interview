module Imports
  class Transactions < Trailblazer::Operation
    BATCH_SIZE = 5000

    pass :setup_coffeeshop_mapper
    pass :setup_employee_mapper
    pass :setup_coffee_mapper
    step :import_transactions

    def setup_coffeeshop_mapper(options, **)
      options['coffeeshop_mapper'] = Mappers::CoffeeshopMapper.call
    end

    def setup_employee_mapper(options, **)
      options['employee_mapper'] = Mappers::EmployeeMapper.call
    end

    def setup_coffee_mapper(options, **)
      options['coffee_mapper'] = Mappers::CoffeeMapper.call
    end

    def import_transactions(options, file_path:, **)
      transactions = []

      CSV.foreach(file_path, headers: true).with_index(1) do |row, index|
        transactions << build_transaction(
          options['coffeeshop_mapper'],
          options['employee_mapper'],
          options['coffee_mapper'],
          row
        )

        if index % BATCH_SIZE == 0
          Transaction.import(transactions) && transactions.clear
        end
      end

      Transaction.import(transactions)
    end

    private

    def build_transaction(cofeeshops, employees, coffees, row)
      Transaction.new(
        coffeeshop_id: cofeeshops.fetch(row.fetch('coffeeshop')),
        employee_id: employees.fetch(row.fetch('employee')),
        coffee_id: coffees.fetch(row.fetch('coffee')),
        price: row.fetch('price'),
        sold_at: DateTime.parse(row.fetch('sold_at'))
      )
    end
  end
end
