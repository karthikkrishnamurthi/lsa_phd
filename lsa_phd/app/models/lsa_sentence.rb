class LsaSentence < ActiveRecord::Base
  attr_accessible :lsa_document_id, :sentence, :document_id
  has_many	:lsa_words, :dependent => :delete_all
  belongs_to :lsa_document
  belongs_to :document
end
