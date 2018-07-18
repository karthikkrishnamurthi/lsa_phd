class Document < ActiveRecord::Base
  attr_accessible :content, :title, :label, :docno, :date
  has_many	:sentences, :dependent => :delete_all
  has_many	:words, :dependent => :delete_all
  has_many	:lsa_sentences, :dependent => :delete_all
  has_many	:lsa_test_sentences, :dependent => :delete_all
  has_many	:flsa_results, :dependent => :delete_all
end
