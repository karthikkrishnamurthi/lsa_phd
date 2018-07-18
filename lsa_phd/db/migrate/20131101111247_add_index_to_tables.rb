class AddIndexToTables < ActiveRecord::Migration
  def change
  	add_index	:lsa_sentences,	:lsa_document_id, :name => 'lsa_document_id_index'
  	add_index	:lsa_test_sentences,	:lsa_document_id, :name => 'lsa_document_id_index'
  	add_index	:lsa_words,	:lsa_document_id, :name => 'lsa_document_id_index'
  	add_index	:lsa_test_words,	:lsa_document_id, :name => 'lsa_document_id_index'
  end
end
