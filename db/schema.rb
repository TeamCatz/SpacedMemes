# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150411222809) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "base_images", force: :cascade do |t|
    t.string "src"
    t.string "title"
    t.date   "date"
  end

  create_table "base_images_", id: :bigserial, force: :cascade do |t|
    t.string "src",   null: false
    t.string "title", null: false
    t.date   "date",  null: false
  end

  create_table "images", force: :cascade do |t|
    t.string "src"
  end

  create_table "images_", id: false, force: :cascade do |t|
    t.integer "id",  limit: 8, default: "nextval('images_id_seq'::regclass)", null: false
    t.string  "src",                                                          null: false
  end

  create_table "tags", force: :cascade do |t|
    t.integer "base_image_id"
    t.string  "tag"
  end

  create_table "tags_", id: :bigserial, force: :cascade do |t|
    t.integer "base_image_id", null: false
    t.string  "tag",           null: false
  end

end
