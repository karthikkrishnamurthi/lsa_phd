class CreateSentences < ActiveRecord::Migration
  def change
    create_table :sentences do |t|
      t.string :sentence
      t.integer :document_id

      t.timestamps
    end
  end
end
