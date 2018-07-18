Lsa::Application.routes.draw do

  resources :lsa_training_unique_words


  resources :flsa_results


  resources :lsa_test_words


  resources :lsa_test_sentences


  resources :lsa_words
  resources :lsa_sentences
  resources :lsa_documents
  resources :words
  resources :sentences
  resources :documents
  root to: 'documents#index'
  match ':controller(/:action(/:id))(.:format)'
end
