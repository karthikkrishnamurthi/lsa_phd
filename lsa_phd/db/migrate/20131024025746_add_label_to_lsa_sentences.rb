class AddLabelToLsaSentences < ActiveRecord::Migration
  def change
  	add_column	:lsa_sentences,	:label,	:string
  end
end
