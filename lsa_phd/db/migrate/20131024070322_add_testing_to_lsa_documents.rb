class AddTestingToLsaDocuments < ActiveRecord::Migration
  def change
  	add_column	:lsa_documents,	:testing,	:string
  end
end
