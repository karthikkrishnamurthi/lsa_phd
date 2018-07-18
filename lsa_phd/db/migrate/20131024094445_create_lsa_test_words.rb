class CreateLsaTestWords < ActiveRecord::Migration
  def change
    create_table :lsa_test_words do |t|
      t.integer :lsa_document_id
      t.integer :lsa_test_sentence_id
      t.string :word

      t.timestamps
    end
  end
end
