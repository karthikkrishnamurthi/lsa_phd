class AddMatrixToDocument < ActiveRecord::Migration
  def change
    add_column :documents, :matrix, :longtext
  end
end
