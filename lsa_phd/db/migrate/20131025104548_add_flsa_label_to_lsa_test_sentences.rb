class AddFlsaLabelToLsaTestSentences < ActiveRecord::Migration
  def change
   	add_column	:lsa_test_sentences, :flsa_label, :string
  end
end
