class AddLabelToLsaWords < ActiveRecord::Migration
  def change
  	add_column	:lsa_words,	:label,	:string
  	add_column	:lsa_test_words,	:label,	:string
  end
end
