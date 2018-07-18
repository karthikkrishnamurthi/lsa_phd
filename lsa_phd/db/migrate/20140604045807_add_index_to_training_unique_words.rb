class AddIndexToTrainingUniqueWords < ActiveRecord::Migration
  def change
  	add_index	:lsa_training_unique_words, :lsa_document_id,	:name => "lsa_document_index"
  end
end
