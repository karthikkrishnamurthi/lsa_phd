class CreateLsaWords < ActiveRecord::Migration
  def change
    create_table :lsa_words do |t|
      t.string :word
      t.integer :lsa_sentence_id
      t.integer :lsa_document_id
      t.timestamps
    end
  end
end
