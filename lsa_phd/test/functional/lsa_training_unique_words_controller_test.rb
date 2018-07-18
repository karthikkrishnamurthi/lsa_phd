require 'test_helper'

class LsaTrainingUniqueWordsControllerTest < ActionController::TestCase
  setup do
    @lsa_training_unique_word = lsa_training_unique_words(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lsa_training_unique_words)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create lsa_training_unique_word" do
    assert_difference('LsaTrainingUniqueWord.count') do
      post :create, lsa_training_unique_word: { category_frequency: @lsa_training_unique_word.category_frequency, icf: @lsa_training_unique_word.icf, lsa_document_id: @lsa_training_unique_word.lsa_document_id, word: @lsa_training_unique_word.word }
    end

    assert_redirected_to lsa_training_unique_word_path(assigns(:lsa_training_unique_word))
  end

  test "should show lsa_training_unique_word" do
    get :show, id: @lsa_training_unique_word
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @lsa_training_unique_word
    assert_response :success
  end

  test "should update lsa_training_unique_word" do
    put :update, id: @lsa_training_unique_word, lsa_training_unique_word: { category_frequency: @lsa_training_unique_word.category_frequency, icf: @lsa_training_unique_word.icf, lsa_document_id: @lsa_training_unique_word.lsa_document_id, word: @lsa_training_unique_word.word }
    assert_redirected_to lsa_training_unique_word_path(assigns(:lsa_training_unique_word))
  end

  test "should destroy lsa_training_unique_word" do
    assert_difference('LsaTrainingUniqueWord.count', -1) do
      delete :destroy, id: @lsa_training_unique_word
    end

    assert_redirected_to lsa_training_unique_words_path
  end
end
