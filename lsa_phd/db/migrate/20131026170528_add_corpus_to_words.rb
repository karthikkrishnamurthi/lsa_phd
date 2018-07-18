class AddCorpusToWords < ActiveRecord::Migration
  def change
  	add_column	:words,	:corpus, :integer
  end
end
