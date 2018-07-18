class AddFlsaMatrixToLsaDocuments < ActiveRecord::Migration
  def change
  	add_column	:lsa_documents,	:flsa_matrix, :longtext
  end
end
