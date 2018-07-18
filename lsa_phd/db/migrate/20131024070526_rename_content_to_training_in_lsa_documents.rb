class RenameContentToTrainingInLsaDocuments < ActiveRecord::Migration
  def up
  	rename_column	:lsa_documents,	:content,	:training
  end

  def down
  end
end
