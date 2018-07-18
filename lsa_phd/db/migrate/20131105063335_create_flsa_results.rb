class CreateFlsaResults < ActiveRecord::Migration
  def change
    create_table :flsa_results do |t|
      t.integer :lsa_document_id
      t.integer :document_id
      t.string :label
      t.string :lsa_label
      t.string :flsa_label
      t.float :precision
      t.float :recall
      t.float :f_measure
      t.float :lsa_max_similarity
      t.float :flsa_max_similarity

      t.timestamps
    end
  end
end
