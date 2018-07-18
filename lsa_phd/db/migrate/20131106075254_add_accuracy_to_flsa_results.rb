class AddAccuracyToFlsaResults < ActiveRecord::Migration
  def change
  	add_column	:flsa_results,	:accuracy,	:float
  	add_column	:flsa_results,	:flsa_accuracy,	:float
  end
end
