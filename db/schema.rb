# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_10_14_000006) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "coffees", force: :cascade do |t|
    t.text "name"
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
  end

  create_table "coffeeshop_coffees", force: :cascade do |t|
    t.bigint "coffeeshop_id"
    t.bigint "coffee_id"
    t.text "identifier"
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["coffee_id"], name: "index_coffeeshop_coffees_on_coffee_id"
    t.index ["coffeeshop_id"], name: "index_coffeeshop_coffees_on_coffeeshop_id"
  end

  create_table "coffeeshops", force: :cascade do |t|
    t.text "identifier"
    t.text "name"
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
  end

  create_table "employees", force: :cascade do |t|
    t.bigint "coffeeshop_id"
    t.text "identifier"
    t.text "name"
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["coffeeshop_id"], name: "index_employees_on_coffeeshop_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.bigint "coffeeshop_id"
    t.bigint "employee_id"
    t.bigint "coffee_id"
    t.decimal "price"
    t.datetime "sold_at"
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["coffee_id"], name: "index_transactions_on_coffee_id"
    t.index ["coffeeshop_id"], name: "index_transactions_on_coffeeshop_id"
    t.index ["employee_id"], name: "index_transactions_on_employee_id"
  end

  create_table "weeks", force: :cascade do |t|
    t.date "week_start"
    t.date "week_end"
  end

  add_foreign_key "coffeeshop_coffees", "coffees"
  add_foreign_key "coffeeshop_coffees", "coffeeshops"
  add_foreign_key "employees", "coffeeshops"
  add_foreign_key "transactions", "coffees"
  add_foreign_key "transactions", "coffeeshops"
  add_foreign_key "transactions", "employees"
end
