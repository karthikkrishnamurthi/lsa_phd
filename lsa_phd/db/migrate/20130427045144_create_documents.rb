class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.date :date
      t.string :title
      t.text :content
      t.timestamps
    end
  end
end
