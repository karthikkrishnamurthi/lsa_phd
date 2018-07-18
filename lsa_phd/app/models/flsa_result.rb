class FlsaResult < ActiveRecord::Base
  attr_accessible :document_id, :f_measure, :flsa_label, :flsa_max_similarity, :label, :lsa_document_id, :lsa_label, :lsa_max_similarity, :precision, :recall
  belongs_to :lsa_document
  belongs_to :document
end
