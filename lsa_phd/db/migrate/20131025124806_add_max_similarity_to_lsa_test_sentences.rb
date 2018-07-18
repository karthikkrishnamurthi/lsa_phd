class AddMaxSimilarityToLsaTestSentences < ActiveRecord::Migration
  def change
  	add_column	:lsa_test_sentences, :lsa_max_similarity, :float
  	add_column  :lsa_test_sentences, :flsa_max_similarity, :float
  end
end
