require 'test_helper'

class LsaSentencesControllerTest < ActionController::TestCase
  setup do
    @lsa_sentence = lsa_sentences(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lsa_sentences)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create lsa_sentence" do
    assert_difference('LsaSentence.count') do
      post :create, lsa_sentence: { integer: @lsa_sentence.integer, lsa_document_id: @lsa_sentence.lsa_document_id, sentence: @lsa_sentence.sentence, text,: @lsa_sentence.text, }
    end

    assert_redirected_to lsa_sentence_path(assigns(:lsa_sentence))
  end

  test "should show lsa_sentence" do
    get :show, id: @lsa_sentence
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @lsa_sentence
    assert_response :success
  end

  test "should update lsa_sentence" do
    put :update, id: @lsa_sentence, lsa_sentence: { integer: @lsa_sentence.integer, lsa_document_id: @lsa_sentence.lsa_document_id, sentence: @lsa_sentence.sentence, text,: @lsa_sentence.text, }
    assert_redirected_to lsa_sentence_path(assigns(:lsa_sentence))
  end

  test "should destroy lsa_sentence" do
    assert_difference('LsaSentence.count', -1) do
      delete :destroy, id: @lsa_sentence
    end

    assert_redirected_to lsa_sentences_path
  end
end
