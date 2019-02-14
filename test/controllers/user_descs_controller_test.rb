require 'test_helper'

class UserDescsControllerTest < ActionController::TestCase
  setup do
    @user_desc = user_descs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_descs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_desc" do
    assert_difference('UserDesc.count') do
      post :create, user_desc: { address: @user_desc.address, fname: @user_desc.fname, lname: @user_desc.lname, sname: @user_desc.sname, user_id: @user_desc.user_id }
    end

    assert_redirected_to user_desc_path(assigns(:user_desc))
  end

  test "should show user_desc" do
    get :show, id: @user_desc
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_desc
    assert_response :success
  end

  test "should update user_desc" do
    patch :update, id: @user_desc, user_desc: { address: @user_desc.address, fname: @user_desc.fname, lname: @user_desc.lname, sname: @user_desc.sname, user_id: @user_desc.user_id }
    assert_redirected_to user_desc_path(assigns(:user_desc))
  end

  test "should destroy user_desc" do
    assert_difference('UserDesc.count', -1) do
      delete :destroy, id: @user_desc
    end

    assert_redirected_to user_descs_path
  end
end
