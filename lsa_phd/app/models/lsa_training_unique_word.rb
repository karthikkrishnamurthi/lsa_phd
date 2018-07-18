class LsaTrainingUniqueWord < ActiveRecord::Base
  attr_accessible :category_frequency, :icf, :lsa_document_id, :word, :occurrence
  belongs_to :lsa_document
end
