class Transaction < ApplicationRecord
  belongs_to :coffeeshop
  belongs_to :employee
  belongs_to :coffee
end
