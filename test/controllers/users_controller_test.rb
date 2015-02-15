require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  def setup                                           
    @base_title = "Ruby on Rails Tutorial Sample App" 
    @admin = users(:admin)
    @not_admin = users(:vitaly)
  end                                                 

  test "should get signup" do
    get :new
    assert_response :success
    assert_select "title", "Sign up | #{@base_title}"
  end

  test "should redirect index when not logged in" do
    get :index
    assert_redirected_to login_url
  end

  test "should redirect edit when not logged in" do
    get :edit, id: @admin
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch :update, id: @admin, user: { name: @admin.name, email: @admin.email }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect edit when logged in as wrong user" do
    log_in_as(@not_admin)
    get :edit, id: @admin
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@not_admin)
    patch :update, id: @admin, user: { name: @admin.name, email: @admin.email }
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should not allow the admin attribute to be edited via the web" do
    log_in_as(@not_admin)
    assert_not @not_admin.admin?
    patch :update, id: @not_admin, user: { password:              'zx12as',
                                            password_confirmation: 'zx12as',
                                            admin:                 :false }

    assert_not @not_admin.admin?
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'User.count' do
      delete :destroy, id: @admin
    end
    assert_redirected_to login_url
   end

  test "should redirect destroy when logged in as a non-admin" do
    log_in_as(@not_admin)
    assert_no_difference 'User.count' do
      delete :destroy, id: @admin
    end
    assert_redirected_to root_url
  end
end
