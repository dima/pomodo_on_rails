require 'test_helper'

class AddressesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:addresses)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_address
    assert_difference('Address.count') do
      post :create, :address => { }
    end

    assert_redirected_to address_path(assigns(:address))
  end

  def test_should_show_address
    get :show, :id => addresses(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => addresses(:one).id
    assert_response :success
  end

  def test_should_update_address
    put :update, :id => addresses(:one).id, :address => { }
    assert_redirected_to address_path(assigns(:address))
  end

  def test_should_destroy_address
    assert_difference('Address.count', -1) do
      delete :destroy, :id => addresses(:one).id
    end

    assert_redirected_to addresses_path
  end
end
