require 'test_helper'

class LsaTestSentencesControllerTest < ActionController::TestCase
  setup do
    @lsa_test_sentence = lsa_test_sentences(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lsa_test_sentences)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create lsa_test_sentence" do
    assert_difference('LsaTestSentence.count') do
      post :create, lsa_test_sentence: { document_id: @lsa_test_sentence.document_id, f_measure: @lsa_test_sentence.f_measure, label: @lsa_test_sentence.label, lsa_document_id: @lsa_test_sentence.lsa_document_id, lsa_label: @lsa_test_sentence.lsa_label, precision: @lsa_test_sentence.precision, recall: @lsa_test_sentence.recall, sentence: @lsa_test_sentence.sentence, similarity: @lsa_test_sentence.similarity }
    end

    assert_redirected_to lsa_test_sentence_path(assigns(:lsa_test_sentence))
  end

  test "should show lsa_test_sentence" do
    get :show, id: @lsa_test_sentence
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @lsa_test_sentence
    assert_response :success
  end

  test "should update lsa_test_sentence" do
    put :update, id: @lsa_test_sentence, lsa_test_sentence: { document_id: @lsa_test_sentence.document_id, f_measure: @lsa_test_sentence.f_measure, label: @lsa_test_sentence.label, lsa_document_id: @lsa_test_sentence.lsa_document_id, lsa_label: @lsa_test_sentence.lsa_label, precision: @lsa_test_sentence.precision, recall: @lsa_test_sentence.recall, sentence: @lsa_test_sentence.sentence, similarity: @lsa_test_sentence.similarity }
    assert_redirected_to lsa_test_sentence_path(assigns(:lsa_test_sentence))
  end

  test "should destroy lsa_test_sentence" do
    assert_difference('LsaTestSentence.count', -1) do
      delete :destroy, id: @lsa_test_sentence
    end

    assert_redirected_to lsa_test_sentences_path
  end
end
