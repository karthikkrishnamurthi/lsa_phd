class AddFlsaSimilarityToLsaTestSentences < ActiveRecord::Migration
  def change
  	add_column	:lsa_test_sentences, :flsa_similarity, :text
  end
end
