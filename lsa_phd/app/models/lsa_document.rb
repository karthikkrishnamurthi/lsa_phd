class LsaDocument < ActiveRecord::Base
  attr_accessible :title, :matrix, :testing, :training
  has_many	:lsa_sentences, :dependent => :delete_all
  has_many	:lsa_test_sentences, :dependent => :delete_all
  has_many	:lsa_words, :dependent => :delete_all
  has_many	:lsa_test_words, :dependent => :delete_all
  has_many	:flsa_results, :dependent => :delete_all
  has_many	:lsa_training_unique_words, :dependent => :delete_all
end
