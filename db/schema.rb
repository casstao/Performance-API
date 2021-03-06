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

ActiveRecord::Schema.define(version: 2021_01_28_040638) do

  create_table "cages", force: :cascade do |t|
    t.integer "max_capacity"
    t.integer "current_capacity"
    t.string "status"
    t.string "cage_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dinos", force: :cascade do |t|
    t.string "name"
    t.string "species"
    t.string "dino_type"
    t.integer "cage_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cage_id"], name: "index_dinos_on_cage_id"
  end

end
