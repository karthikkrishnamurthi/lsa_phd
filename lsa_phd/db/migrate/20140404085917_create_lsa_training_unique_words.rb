class CreateLsaTrainingUniqueWords < ActiveRecord::Migration
  def change
    create_table :lsa_training_unique_words do |t|
      t.string :word
      t.integer :category_frequency
      t.float :icf
      t.integer :lsa_document_id

      t.timestamps
    end
  end
end
