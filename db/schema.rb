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

ActiveRecord::Schema.define(version: 2020_08_03_215708) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attendances", force: :cascade do |t|
    t.bigint "attendee_id", null: false
    t.bigint "attended_event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["attended_event_id"], name: "index_attendances_on_attended_event_id"
    t.index ["attendee_id", "attended_event_id"], name: "index_attendances_on_attendee_id_and_attended_event_id", unique: true
    t.index ["attendee_id"], name: "index_attendances_on_attendee_id"
  end

  create_table "events", force: :cascade do |t|
    t.datetime "date"
    t.integer "creator_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "description"
    t.string "title", null: false
    t.string "location"
    t.boolean "accessibility", default: false, null: false
  end

  create_table "invitations", force: :cascade do |t|
    t.bigint "host_id", null: false
    t.bigint "invitee_id", null: false
    t.bigint "event_id", null: false
    t.string "status", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_invitations_on_event_id"
    t.index ["host_id", "invitee_id", "event_id"], name: "index_invitations_on_host_id_and_invitee_id_and_event_id", unique: true
    t.index ["host_id"], name: "index_invitations_on_host_id"
    t.index ["invitee_id"], name: "index_invitations_on_invitee_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "attendances", "events", column: "attended_event_id"
  add_foreign_key "attendances", "users", column: "attendee_id"
  add_foreign_key "invitations", "events"
  add_foreign_key "invitations", "users", column: "host_id"
  add_foreign_key "invitations", "users", column: "invitee_id"
end
