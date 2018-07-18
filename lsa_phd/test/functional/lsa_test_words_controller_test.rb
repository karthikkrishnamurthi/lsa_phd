require 'test_helper'

class LsaTestWordsControllerTest < ActionController::TestCase
  setup do
    @lsa_test_word = lsa_test_words(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lsa_test_words)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create lsa_test_word" do
    assert_difference('LsaTestWord.count') do
      post :create, lsa_test_word: { lsa_document_id: @lsa_test_word.lsa_document_id, lsa_test_sentence_id: @lsa_test_word.lsa_test_sentence_id, word: @lsa_test_word.word }
    end

    assert_redirected_to lsa_test_word_path(assigns(:lsa_test_word))
  end

  test "should show lsa_test_word" do
    get :show, id: @lsa_test_word
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @lsa_test_word
    assert_response :success
  end

  test "should update lsa_test_word" do
    put :update, id: @lsa_test_word, lsa_test_word: { lsa_document_id: @lsa_test_word.lsa_document_id, lsa_test_sentence_id: @lsa_test_word.lsa_test_sentence_id, word: @lsa_test_word.word }
    assert_redirected_to lsa_test_word_path(assigns(:lsa_test_word))
  end

  test "should destroy lsa_test_word" do
    assert_difference('LsaTestWord.count', -1) do
      delete :destroy, id: @lsa_test_word
    end

    assert_redirected_to lsa_test_words_path
  end
end
