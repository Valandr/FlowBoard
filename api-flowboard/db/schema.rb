# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_02_17_094612) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "figures", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "duration"
    t.string "video_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "category", default: [], array: true
    t.integer "skill_level"
  end

  create_table "figures_users", id: false, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "figure_id", null: false
    t.index ["figure_id", "user_id"], name: "index_figures_users_on_figure_id_and_user_id"
    t.index ["user_id", "figure_id"], name: "index_figures_users_on_user_id_and_figure_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest"
    t.integer "level", default: 0
    t.integer "session_duration", default: 0
    t.string "jti", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role"
    t.index ["email"], name: "index_users_on_email", unique: true
  end
end
