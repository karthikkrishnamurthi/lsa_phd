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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140604045807) do

  create_table "documents", :force => true do |t|
    t.date     "date"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.text     "matrix",     :limit => 2147483647
    t.string   "label"
    t.integer  "docno"
  end

  create_table "flsa_results", :force => true do |t|
    t.integer  "lsa_document_id"
    t.integer  "document_id"
    t.string   "label"
    t.string   "lsa_label"
    t.string   "flsa_label"
    t.float    "precision"
    t.float    "recall"
    t.float    "f_measure"
    t.float    "lsa_max_similarity"
    t.float    "flsa_max_similarity"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.integer  "dimension"
    t.float    "accuracy"
    t.float    "flsa_accuracy"
  end

  create_table "lsa_documents", :force => true do |t|
    t.string   "title"
    t.text     "training"
    t.text     "matrix",      :limit => 2147483647
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.string   "testing"
    t.text     "flsa_matrix", :limit => 2147483647
  end

  create_table "lsa_sentences", :force => true do |t|
    t.text     "sentence"
    t.integer  "lsa_document_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "label"
    t.integer  "document_id"
  end

  add_index "lsa_sentences", ["lsa_document_id"], :name => "lsa_document_id_index"

  create_table "lsa_test_sentences", :force => true do |t|
    t.integer  "lsa_document_id"
    t.integer  "document_id"
    t.string   "label"
    t.string   "lsa_label"
    t.float    "precision"
    t.float    "recall"
    t.float    "f_measure"
    t.text     "similarity",          :limit => 2147483647
    t.text     "sentence"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.text     "matrix",              :limit => 2147483647
    t.text     "flsa_similarity",     :limit => 2147483647
    t.string   "flsa_label"
    t.text     "flsa_matrix",         :limit => 2147483647
    t.float    "lsa_max_similarity"
    t.float    "flsa_max_similarity"
  end

  add_index "lsa_test_sentences", ["lsa_document_id"], :name => "lsa_document_id_index"

  create_table "lsa_test_words", :force => true do |t|
    t.integer  "lsa_document_id"
    t.integer  "lsa_test_sentence_id"
    t.string   "word"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.string   "label"
  end

  add_index "lsa_test_words", ["lsa_document_id"], :name => "lsa_document_id_index"

  create_table "lsa_training_unique_words", :force => true do |t|
    t.string   "word"
    t.integer  "category_frequency"
    t.float    "icf"
    t.integer  "lsa_document_id"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.text     "occurrence",         :limit => 2147483647
  end

  add_index "lsa_training_unique_words", ["lsa_document_id"], :name => "lsa_document_index"

  create_table "lsa_words", :force => true do |t|
    t.string   "word"
    t.integer  "lsa_sentence_id"
    t.integer  "lsa_document_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "label"
  end

  add_index "lsa_words", ["lsa_document_id"], :name => "lsa_document_id_index"

  create_table "sentences", :force => true do |t|
    t.string   "sentence"
    t.integer  "document_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "sentences", ["document_id"], :name => "document_index"

  create_table "words", :force => true do |t|
    t.string   "word"
    t.integer  "sentence_id"
    t.integer  "document_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "corpus"
  end

  add_index "words", ["document_id"], :name => "document_index"
  add_index "words", ["sentence_id"], :name => "sentence_index"

end
