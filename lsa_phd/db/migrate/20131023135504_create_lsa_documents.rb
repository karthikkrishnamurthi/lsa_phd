class CreateLsaDocuments < ActiveRecord::Migration
  def change
    create_table :lsa_documents do |t|
      t.string :title
      t.text :content
      t.text :matrix
      t.timestamps
    end
  end
end
