class LsaWord < ActiveRecord::Base
  attr_accessible :lsa_document_id, :lsa_sentence_id, :word
  belongs_to	:lsa_sentence
  belongs_to	:lsa_document
end
