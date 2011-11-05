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

ActiveRecord::Schema.define(:version => 20111105142057) do

  create_table "accounts", :force => true do |t|
    t.string   "name"
    t.string   "hashed_password"
    t.string   "salt"
    t.string   "account_type"
    t.integer  "user_id"
    t.string   "request_token"
    t.string   "request_token_secret"
    t.string   "access_token"
    t.string   "access_token_secret"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "security_account_id"
  end

  create_table "cities", :force => true do |t|
    t.string   "name"
    t.string   "area_code"
    t.string   "pinyin"
    t.integer  "rate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups_users", :id => false, :force => true do |t|
    t.integer  "group_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", :force => true do |t|
    t.integer  "user_id"
    t.integer  "other_user_id"
    t.integer  "message_type"
    t.text     "content"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "yueyue_object_id"
  end

  create_table "users", :force => true do |t|
    t.string   "nick_name"
    t.string   "profile_image_url"
    t.string   "description"
    t.string   "gender"
    t.string   "city"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role"
    t.string   "signature"
  end

  create_table "users_yueyue_objects", :id => false, :force => true do |t|
    t.integer  "yueyue_object_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "yueyue_object_properties", :force => true do |t|
    t.integer  "yueyue_object_id",        :null => false
    t.integer  "yueyue_type_property_id", :null => false
    t.string   "property_value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "yueyue_objects", :force => true do |t|
    t.integer  "yueyue_type_id", :null => false
    t.string   "title"
    t.string   "owner_id"
    t.datetime "yueyue_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "rate"
    t.string   "address"
  end

  create_table "yueyue_type_actions", :force => true do |t|
    t.integer  "yueyue_type_id", :null => false
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "yueyue_type_properties", :force => true do |t|
    t.string   "name"
    t.string   "default_value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "builder"
  end

  create_table "yueyue_type_properties_yueyue_types", :id => false, :force => true do |t|
    t.integer  "yueyue_type_id"
    t.integer  "yueyue_type_property_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "yueyue_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
