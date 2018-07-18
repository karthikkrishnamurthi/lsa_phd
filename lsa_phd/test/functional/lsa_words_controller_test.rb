require 'test_helper'

class LsaWordsControllerTest < ActionController::TestCase
  setup do
    @lsa_word = lsa_words(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lsa_words)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create lsa_word" do
    assert_difference('LsaWord.count') do
      post :create, lsa_word: { : @lsa_word., : @lsa_word., : @lsa_word., integer,: @lsa_word.integer,, integer: @lsa_word.integer, string,: @lsa_word.string, }
    end

    assert_redirected_to lsa_word_path(assigns(:lsa_word))
  end

  test "should show lsa_word" do
    get :show, id: @lsa_word
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @lsa_word
    assert_response :success
  end

  test "should update lsa_word" do
    put :update, id: @lsa_word, lsa_word: { : @lsa_word., : @lsa_word., : @lsa_word., integer,: @lsa_word.integer,, integer: @lsa_word.integer, string,: @lsa_word.string, }
    assert_redirected_to lsa_word_path(assigns(:lsa_word))
  end

  test "should destroy lsa_word" do
    assert_difference('LsaWord.count', -1) do
      delete :destroy, id: @lsa_word
    end

    assert_redirected_to lsa_words_path
  end
end
