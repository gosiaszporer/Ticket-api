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

ActiveRecord::Schema.define(version: 2019_10_24_190052) do

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.datetime "date"
    t.boolean "even", default: false, null: false
    t.boolean "all_together", default: false, null: false
    t.boolean "avoid_one", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reservation_details", force: :cascade do |t|
    t.integer "quantity"
    t.integer "reservation_id"
    t.integer "ticket_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reservation_id"], name: "index_reservation_details_on_reservation_id"
    t.index ["ticket_id"], name: "index_reservation_details_on_ticket_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.string "email"
    t.integer "status"
    t.integer "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_reservations_on_event_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.string "name"
    t.float "price"
    t.integer "quantity"
    t.integer "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_tickets_on_event_id"
  end

end
