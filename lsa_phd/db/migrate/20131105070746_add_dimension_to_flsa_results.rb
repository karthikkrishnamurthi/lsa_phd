class AddDimensionToFlsaResults < ActiveRecord::Migration
  def change
  	add_column	:flsa_results,	:dimension,	:integer
  end
end
