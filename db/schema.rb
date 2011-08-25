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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110825145258) do

  create_table "movies", :force => true do |t|
    t.string   "description"
    t.datetime "yueyue_date"
    t.string   "movie_name"
    t.string   "place"
    t.integer  "ticket_fee"
    t.string   "yueyue_owner"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "movies_users", :id => false, :force => true do |t|
    t.integer  "movie_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sanguoshas", :force => true do |t|
    t.string   "description"
    t.datetime "yueyue_date"
    t.string   "place"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "yueyue_owner"
  end

  create_table "sanguoshas_users", :id => false, :force => true do |t|
    t.integer  "sanguosha_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "hashed_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
