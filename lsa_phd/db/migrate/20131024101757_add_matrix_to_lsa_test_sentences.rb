class AddMatrixToLsaTestSentences < ActiveRecord::Migration
  def change
  	add_column	:lsa_test_sentences,	:matrix,	:longtext
  end
end
