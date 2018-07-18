class ChangeDatatypeInLsaTestSentences < ActiveRecord::Migration
  def up
  	change_column :lsa_test_sentences, :similarity, :longtext
  	change_column :lsa_test_sentences, :matrix, :longtext
  	change_column :lsa_test_sentences, :flsa_similarity, :longtext
  	change_column :lsa_test_sentences, :flsa_matrix, :longtext
  end

  def down
  end
end
