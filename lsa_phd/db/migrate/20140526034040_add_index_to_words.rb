class AddIndexToWords < ActiveRecord::Migration
  def change
  	add_index	:words, :document_id,	:name => "document_index"
  	add_index	:words, :sentence_id,	:name => "sentence_index"
  end
end
