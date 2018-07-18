class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :word
      t.integer :sentence_id
      t.integer :document_id

      t.timestamps
    end
  end
end
