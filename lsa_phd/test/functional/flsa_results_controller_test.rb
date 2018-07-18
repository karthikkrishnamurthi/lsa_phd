require 'test_helper'

class FlsaResultsControllerTest < ActionController::TestCase
  setup do
    @flsa_result = flsa_results(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:flsa_results)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create flsa_result" do
    assert_difference('FlsaResult.count') do
      post :create, flsa_result: { document_id: @flsa_result.document_id, f_measure: @flsa_result.f_measure, flsa_label: @flsa_result.flsa_label, flsa_max_similarity: @flsa_result.flsa_max_similarity, label: @flsa_result.label, lsa_document_id: @flsa_result.lsa_document_id, lsa_label: @flsa_result.lsa_label, lsa_max_similarity: @flsa_result.lsa_max_similarity, precision: @flsa_result.precision, recall: @flsa_result.recall }
    end

    assert_redirected_to flsa_result_path(assigns(:flsa_result))
  end

  test "should show flsa_result" do
    get :show, id: @flsa_result
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @flsa_result
    assert_response :success
  end

  test "should update flsa_result" do
    put :update, id: @flsa_result, flsa_result: { document_id: @flsa_result.document_id, f_measure: @flsa_result.f_measure, flsa_label: @flsa_result.flsa_label, flsa_max_similarity: @flsa_result.flsa_max_similarity, label: @flsa_result.label, lsa_document_id: @flsa_result.lsa_document_id, lsa_label: @flsa_result.lsa_label, lsa_max_similarity: @flsa_result.lsa_max_similarity, precision: @flsa_result.precision, recall: @flsa_result.recall }
    assert_redirected_to flsa_result_path(assigns(:flsa_result))
  end

  test "should destroy flsa_result" do
    assert_difference('FlsaResult.count', -1) do
      delete :destroy, id: @flsa_result
    end

    assert_redirected_to flsa_results_path
  end
end
