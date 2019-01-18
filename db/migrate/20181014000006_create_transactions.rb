class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.references :coffeeshop, foreign_key: true
      t.references :employee, foreign_key: true
      t.references :coffee, foreign_key: true
      t.numeric :price
      t.timestamp :sold_at

      t.timestamps(default: -> { 'CURRENT_TIMESTAMP' })
    end
  end
end
