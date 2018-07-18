class AddDocumentIndexToSentences < ActiveRecord::Migration
  def change
  	add_index	:sentences, :document_id,	:name => "document_index"
  end
end
