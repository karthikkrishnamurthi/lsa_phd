class AddDocnoToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :docno, :integer
  end
end
