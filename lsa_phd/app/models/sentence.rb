class Sentence < ActiveRecord::Base
  attr_accessible :document_id, :sentence
  has_many	:words, :dependent => :delete_all
  belongs_to :document
end
