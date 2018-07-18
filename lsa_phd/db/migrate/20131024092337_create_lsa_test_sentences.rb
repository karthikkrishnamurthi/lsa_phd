class CreateLsaTestSentences < ActiveRecord::Migration
  def change
    create_table :lsa_test_sentences do |t|
      t.integer :lsa_document_id
      t.integer :document_id
      t.string :label
      t.string :lsa_label
      t.float :precision
      t.float :recall
      t.float :f_measure
      t.text :similarity
      t.text :sentence

      t.timestamps
    end
  end
end
