class Word < ActiveRecord::Base
  attr_accessible :document_id, :sentence_id, :word, :corpus
  belongs_to	:sentence
  belongs_to	:document
end
