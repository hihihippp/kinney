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

ActiveRecord::Schema.define(version: 20130927201604) do

  create_table "active_admin_comments", force: true do |t|
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_admin_notes_on_resource_type_and_resource_id"

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 40
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", unique: true
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"

  create_table "kinney_admin_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "kinney_admin_users", ["email"], name: "index_admin_users_on_email", unique: true
  add_index "kinney_admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true

  create_table "kinney_clip_people", force: true do |t|
    t.integer  "person_id"
    t.integer  "clip_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "kinney_clip_people", ["clip_id"], name: "index_clip_people_on_clip_id"
  add_index "kinney_clip_people", ["person_id"], name: "index_clip_people_on_person_id"

  create_table "kinney_clip_topics", force: true do |t|
    t.integer  "clip_id"
    t.integer  "topic_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "kinney_clip_topics", ["clip_id"], name: "index_clip_topics_on_clip_id"
  add_index "kinney_clip_topics", ["topic_id"], name: "index_clip_topics_on_topic_id"

  create_table "kinney_clips", force: true do |t|
    t.string   "filename"
    t.string   "title"
    t.text     "quotes"
    t.boolean  "top_pick"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "slug"
    t.integer  "duration"
    t.date     "interview_date"
    t.text     "description"
    t.boolean  "featured"
    t.string   "interview_place"
  end

  add_index "kinney_clips", ["slug"], name: "index_clips_on_slug", unique: true

  create_table "kinney_images", force: true do |t|
    t.string   "filename"
    t.boolean  "top_pick"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "kinney_images", ["id"], name: "index_images_on_id"

  create_table "kinney_people", force: true do |t|
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "nickname"
    t.text     "biography"
    t.text     "accomplishments"
    t.text     "activities"
    t.text     "currently"
    t.text     "citations"
    t.integer  "graduating_class"
    t.text     "term"
    t.text     "term_date_ranges"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "slug"
    t.string   "name_suffix"
    t.string   "location"
    t.string   "honorary"
  end

  add_index "kinney_people", ["slug"], name: "index_people_on_slug", unique: true

  create_table "kinney_person_images", force: true do |t|
    t.integer  "person_id"
    t.integer  "image_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "kinney_person_images", ["image_id"], name: "index_person_images_on_image_id"
  add_index "kinney_person_images", ["person_id"], name: "index_person_images_on_person_id"

  create_table "kinney_topics", force: true do |t|
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "slug"
    t.text     "description"
  end

  add_index "kinney_topics", ["slug"], name: "index_topics_on_slug", unique: true

  create_table "kinney_trackers", force: true do |t|
    t.string   "uuid"
    t.text     "seconds"
    t.string   "video"
    t.string   "site"
    t.date     "time"
    t.string   "session"
    t.boolean  "sessioned"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "kinney_video_sessions", force: true do |t|
    t.string   "uuid"
    t.text     "seconds"
    t.string   "video"
    t.string   "site"
    t.date     "time"
    t.string   "session"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
