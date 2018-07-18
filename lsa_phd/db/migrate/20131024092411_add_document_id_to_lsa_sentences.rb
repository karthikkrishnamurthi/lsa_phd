class AddDocumentIdToLsaSentences < ActiveRecord::Migration
  def change
  	add_column	:lsa_sentences,	:document_id, :integer
  end
end
