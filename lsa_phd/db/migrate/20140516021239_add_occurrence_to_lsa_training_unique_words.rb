class AddOccurrenceToLsaTrainingUniqueWords < ActiveRecord::Migration
  def change
  	add_column	:lsa_training_unique_words,	:occurrence, :longtext
  end
end
