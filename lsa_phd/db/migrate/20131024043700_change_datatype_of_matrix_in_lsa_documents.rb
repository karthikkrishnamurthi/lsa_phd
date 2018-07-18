class ChangeDatatypeOfMatrixInLsaDocuments < ActiveRecord::Migration
  def up
  	change_column :lsa_documents, :matrix, :longtext
  end

  def down
  end
end
