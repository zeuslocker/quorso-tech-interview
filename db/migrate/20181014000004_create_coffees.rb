class CreateCoffees < ActiveRecord::Migration[5.2]
  def change
    create_table :coffees do |t|
      t.text :name
      t.timestamps(default: -> { 'CURRENT_TIMESTAMP' })
    end
  end
end
