require 'test_helper'

class TransfersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:transfers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create transfers" do
    assert_difference('Transfers.count') do
      post :create, :transfers => { }
    end

    assert_redirected_to transfers_path(assigns(:transfers))
  end

  test "should show transfers" do
    get :show, :id => transfers(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => transfers(:one).id
    assert_response :success
  end

  test "should update transfers" do
    put :update, :id => transfers(:one).id, :transfers => { }
    assert_redirected_to transfers_path(assigns(:transfers))
  end

  test "should destroy transfers" do
    assert_difference('Transfers.count', -1) do
      delete :destroy, :id => transfers(:one).id
    end

    assert_redirected_to transfers_path
  end
end
