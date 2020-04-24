ActiveRecord::Schema.define(version: 2020_04_23_085348) do

  enable_extension "plpgsql"

  create_table "tasks", force: :cascade do |t|
    t.string "task_name", null: false
    t.text "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "deadline", null: false
    t.string "status", null: false
    t.integer "rank", null: false
    t.index ["task_name"], name: "index_tasks_on_task_name"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
