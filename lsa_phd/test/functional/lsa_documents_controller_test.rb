require 'test_helper'

class LsaDocumentsControllerTest < ActionController::TestCase
  setup do
    @lsa_document = lsa_documents(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lsa_documents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create lsa_document" do
    assert_difference('LsaDocument.count') do
      post :create, lsa_document: { : @lsa_document., : @lsa_document., : @lsa_document., content: @lsa_document.content, matrix: @lsa_document.matrix, title: @lsa_document.title }
    end

    assert_redirected_to lsa_document_path(assigns(:lsa_document))
  end

  test "should show lsa_document" do
    get :show, id: @lsa_document
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @lsa_document
    assert_response :success
  end

  test "should update lsa_document" do
    put :update, id: @lsa_document, lsa_document: { : @lsa_document., : @lsa_document., : @lsa_document., content: @lsa_document.content, matrix: @lsa_document.matrix, title: @lsa_document.title }
    assert_redirected_to lsa_document_path(assigns(:lsa_document))
  end

  test "should destroy lsa_document" do
    assert_difference('LsaDocument.count', -1) do
      delete :destroy, id: @lsa_document
    end

    assert_redirected_to lsa_documents_path
  end
end
