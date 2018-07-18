class LsaTestSentence < ActiveRecord::Base
  attr_accessible :document_id, :f_measure, :label, :lsa_document_id, :lsa_label, :precision, :recall, :sentence, :similarity
  has_many	:lsa_test_words, :dependent => :delete_all
  belongs_to :lsa_document
  belongs_to :document
end
