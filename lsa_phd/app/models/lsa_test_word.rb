class LsaTestWord < ActiveRecord::Base
  attr_accessible :lsa_document_id, :lsa_test_sentence_id, :word
  belongs_to	:lsa_test_sentence
  belongs_to	:lsa_document
end
