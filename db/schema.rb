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

ActiveRecord::Schema.define(version: 2022_05_28_081302) do

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
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "drawings", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "figure_number"
    t.string "product_name"
    t.string "material"
    t.string "size"
    t.float "weight"
    t.float "area"
    t.string "surface_treatment"
    t.integer "quantity"
    t.integer "price"
    t.string "notes"
    t.bigint "quotation_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["quotation_id"], name: "index_drawings_on_quotation_id"
  end

  create_table "price_scales", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title", null: false
    t.string "surface_treatment", null: false
    t.integer "scale_w_0_3"
    t.integer "scale_w_3_6"
    t.integer "scale_w_6_11"
    t.integer "scale_w_11_15"
    t.integer "scale_w_15_22"
    t.integer "scale_w_22_30"
    t.integer "scale_w_30_50"
    t.integer "scale_w_50_80"
    t.integer "scale_w_80_150"
    t.integer "scale_w_150_180"
    t.integer "scale_w_180over"
    t.integer "scale_a_0_3"
    t.integer "scale_a_3_6"
    t.integer "scale_a_6_11"
    t.integer "scale_a_11_15"
    t.integer "scale_a_15_22"
    t.integer "scale_a_22_30"
    t.integer "scale_a_30_50"
    t.integer "scale_a_50_80"
    t.integer "scale_a_80_150"
    t.integer "scale_a_150_180"
    t.integer "scale_a_180over"
    t.float "scale_o_0_300"
    t.float "scale_o_300_500"
    t.float "scale_o_500over"
    t.integer "min_unit_price"
    t.integer "min_total_price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "quotations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title", null: false
    t.string "charge"
    t.string "delivery_date"
    t.string "expiration_date"
    t.string "delivery_place"
    t.string "business_terms"
    t.integer "total_price"
    t.text "remarks"
    t.text "hidden_remarks"
    t.integer "approval"
    t.integer "printing"
    t.bigint "mk_user_id"
    t.bigint "appro_user_id"
    t.bigint "client_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["appro_user_id"], name: "index_quotations_on_appro_user_id"
    t.index ["client_id"], name: "index_quotations_on_client_id"
    t.index ["mk_user_id"], name: "index_quotations_on_mk_user_id"
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

  add_foreign_key "quotations", "clients"
  add_foreign_key "quotations", "users", column: "appro_user_id"
  add_foreign_key "quotations", "users", column: "mk_user_id"
end
