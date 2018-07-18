class CreateLsaSentences < ActiveRecord::Migration
  def change
    create_table :lsa_sentences do |t|
      t.text :sentence
      t.integer :lsa_document_id
      t.timestamps
    end
  end
end
