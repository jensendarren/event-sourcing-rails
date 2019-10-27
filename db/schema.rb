# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_10_27_031201) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", id: :serial, force: :cascade do |t|
    t.uuid "entity_id", null: false
    t.string "entity_type", null: false
    t.string "event_type", null: false
    t.integer "entity_version", null: false
    t.jsonb "data", null: false
    t.datetime "created_at", null: false
    t.index ["entity_id", "entity_version"], name: "event_version_constraint", unique: true
    t.index ["entity_id"], name: "index_events_on_entity_id"
  end

  create_table "invitees", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.bigint "meeting_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["meeting_id"], name: "index_invitees_on_meeting_id"
  end

  create_table "meetings", force: :cascade do |t|
    t.uuid "entity_id"
    t.datetime "time"
    t.integer "organizer_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "organizers", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
