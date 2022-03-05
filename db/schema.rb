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

ActiveRecord::Schema.define(version: 2022_03_04_160500) do

  create_table "clients", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "name_kana", null: false
    t.string "phone_number", null: false
    t.string "fax_number"
    t.string "email"
    t.string "postal_code", null: false
    t.string "address", null: false
    t.text "person"
    t.text "remarks"
    t.string "value_class", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "pice_scales", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title", null: false
    t.string "surface_treatment", null: false
    t.integer "scale_w_0_3"
    t.integer "scale_w_3_6"
    t.integer "scale_w_6_10"
    t.integer "scale_w_10_15"
    t.integer "scale_w_15_22"
    t.integer "scale_w_22_30"
    t.integer "scale_w_30_40"
    t.integer "scale_w_40_55"
    t.integer "scale_w_55_75"
    t.integer "scale_w_75_100"
    t.integer "scale_w_100over"
    t.integer "scale_a_0_3"
    t.integer "scale_a_3_6"
    t.integer "scale_a_6_10"
    t.integer "scale_a_10_15"
    t.integer "scale_a_15_22"
    t.integer "scale_a_22_30"
    t.integer "scale_a_30_40"
    t.integer "scale_a_40_55"
    t.integer "scale_a_55_75"
    t.integer "scale_a_75_100"
    t.integer "scale_a_100over"
    t.integer "acale_o_0_300"
    t.integer "acale_o_300_500"
    t.integer "acale_o_500over"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "roles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "employee_number", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name", null: false
    t.integer "admin_id", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

end
